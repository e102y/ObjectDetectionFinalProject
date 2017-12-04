scale = 0.2 ; %how is the image scaled?
angleStds = 0.5; %number of acceptable std deviations from mean for the angle of the vector connecting matched points 
distStds = 0.5; %number of acceptable std deviations from the mean of matched point distances



pfx = fullfile('Images', 'im0.png') ; 
I = imread(pfx) ;
I = imresize(I, scale) ;
%figure; image(I) ;
Ia = single(rgb2gray(I)) ;

pfx = fullfile('Images', 'im1.png') ; 
I = imread(pfx) ;
I = imresize(I, scale) ;
%figure, image(I) ;
Ib = single(rgb2gray(I)) ;

[fa, da] = vl_sift(Ia) ; %Computes SIFT features and descriptors
[fb, db] = vl_sift(Ib) ; %Computes SIFT features and descriptors
[matches, scores] = vl_ubcmatch(da, db) ; %function that finds matching descriptors by computing distances between descriptors da and db.

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

figure, imshow(Ia,[]);
hold on;
%line(X(:,1:3:100),Y(:,1:3:100)) %Draws a line between every 3rd feature in the first 100 features
line(X(:,:),Y(:,:))
hold off;

%draw the angle culled version
X=[MatchedPairsAngle(1,:);MatchedPairsAngle(3,:)];
Y=[MatchedPairsAngle(2,:);MatchedPairsAngle(4,:)];

figure, imshow(Ia,[]);
hold on;
%line(X(:,1:3:100),Y(:,1:3:100)) %Draws a line between every 3rd feature in the first 100 features
line(X(:,:),Y(:,:))
hold off;

%draw the angle and dist culled version
X=[MatchedPairsDist(1,:);MatchedPairsDist(3,:)];
Y=[MatchedPairsDist(2,:);MatchedPairsDist(4,:)];

figure, imshow(Ia,[]);
hold on;
%line(X(:,1:3:100),Y(:,1:3:100)) %Draws a line between every 3rd feature in the first 100 features
line(X(:,:),Y(:,:))
hold off;



%interpolate with scatteredInterpolant?
%HeightImg = scatteredInterpolant(X, Y, H);


