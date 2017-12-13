function returnValue = generateMatchedPoints(image)

scale = 0.3 ; %how is the image scaled?
angleStds = 0.7; %number of acceptable std deviations from mean for the angle of the vector connecting matched points 
distStds = 3; %number of acceptable std deviations from the mean of matched point distances
sift_peak_thresh = 1; %reduce to increase feature count
ALLCHANNELS = true;

%pfx = fullfile('Images', 'im0.png') ; 
%figure; image(I) ;
Iaorig = image

%pfx = fullfile('Images', 'im1.png') ; 
pfx = fullfile('Images', 'storage1.png') ; 
Iborig = imread(pfx) ;
Iborig = imresize(Iborig, scale) ;
%figure, image(I) ;


%fc = [100; 100; 10; 0]; %specify frames?

if ALLCHANNELS
%using all channels
fa = [[];[];[];[]];
da = [[];[];[];[]];
fb = [[];[];[];[]];
db = [[];[];[];[]];
matches = [[];[]];
scores = [];
for i = 1:3 
   [tempfa, tempda] = vl_sift(single(Iaorig(:,:,i)), 'PeakThresh', sift_peak_thresh);
   [tempfb, tempdb] = vl_sift(single(Iborig(:,:,i)), 'PeakThresh', sift_peak_thresh);
   %[tempmatches, tempscores] = vl_ubcmatch(tempda, tempdb) ;
   fa = [fa,tempfa];
   fb = [fb,tempfb];
   da = [da,tempda];
   db = [db,tempdb];
   %matches = [matches, tempmatches] ;
   %scores = [scores, tempscores] ;
end
[matches, scores] = vl_ubcmatch(da, db) ;%function that finds matching descriptors by computing distances between descriptors da and db.
else
%will use grayscale
Ia = single(rgb2gray(Iaorig)) ;
Ib = single(rgb2gray(Iborig)) ;
[fa, da] = vl_sift(Ia, 'PeakThresh', sift_peak_thresh);%, 'frames', fc) ; %Computes SIFT features and descriptors
[fb, db] = vl_sift(Ib, 'PeakThresh', sift_peak_thresh);%, 'frames', fc) ; %Computes SIFT features and descriptors
[matches, scores] = vl_ubcmatch(da, db) ; %function that finds matching descriptors by computing distances between descriptors da and db.
end




m1= fa(1:2,matches(1,:)); m2=fb(1:2,matches(2,:)); %Stores the x and y location of the features
deltax = m1(1,:) - m2(1,:) ;
deltay = m1(2,:) - m2(2,:) ;
distances= sqrt((deltax).^2 + (deltay).^2) ;
angles= atan(deltay./deltax); 
meanAngle= mean(angles);
angleStdDeviation= std(angles);
MatchedPairs= [m1; m2; distances; angles] ;
MatchedPairsOrig= MatchedPairs;

upperAngleThresh= meanAngle + (angleStds * angleStdDeviation) ;
lowerAngleThresh= meanAngle - (angleStds * angleStdDeviation) ;

meanDist = mean(MatchedPairs(5,:)) ;
stdDevDist = std(MatchedPairs(5,:)) ;

upperDistThresh= meanDist + (distStds * stdDevDist) ;
lowerDistThresh= meanDist - (distStds * stdDevDist) ;
%Time to Remove angle outliers


%Time to Remove angle outliers
removalIndex= false(1,size(MatchedPairs, 2));
for i = 1:size(MatchedPairs, 2)
    removalIndex(i) = (MatchedPairs(6,i) < lowerAngleThresh) | (MatchedPairs(6,i) > upperAngleThresh);
end
MatchedPairs(:,removalIndex) = [];
MatchedPairsAngle= MatchedPairs;

%Time to Remove distance outliers
removalIndex= false(1,size(MatchedPairs, 2));
for i = 1:size(MatchedPairs, 2)
    removalIndex(i) = (MatchedPairs(5,i) < lowerDistThresh) | (MatchedPairs(5,i) > upperDistThresh);
end
MatchedPairs(:,removalIndex) = [];
MatchedPairsDist= MatchedPairs;

%draw the unculled version
X=[MatchedPairsOrig(1,:);MatchedPairsOrig(3,:)];
Y=[MatchedPairsOrig(2,:);MatchedPairsOrig(4,:)];

%c=[Ia Ib];
stereo = stereoAnaglyph(Iaorig,Iborig);

figure, imshow(stereo,[]);
title('unculled')
hold on;
%line(X(:,1:3:100),Y(:,1:3:100)) %Draws a line between every 3rd feature in the first 100 features
line(X,Y)
hold off;

%draw the angle culled version
X=[MatchedPairsAngle(1,:);MatchedPairsAngle(3,:)];
Y=[MatchedPairsAngle(2,:);MatchedPairsAngle(4,:)];

figure, imshow(stereo,[]);
title('culled based on angle')
hold on;
%line(X(:,1:3:100),Y(:,1:3:100)) %Draws a line between every 3rd feature in the first 100 features
line(X,Y)
hold off;

%draw the angle and dist culled version
X=[MatchedPairsDist(1,:);MatchedPairsDist(3,:)];
Y=[MatchedPairsDist(2,:);MatchedPairsDist(4,:)];

figure, imshow(stereo,[]);
title('culled based on angle and distance')
hold on;
%line(X(:,1:3:100),Y(:,1:3:100)) %Draws a line between every 3rd feature in the first 100 features
line(X,Y)
hold off;

%prepare for next step:
returnValue = MatchedPairsDist(1:4,:);
return

%hough transform to filter out bad matches

