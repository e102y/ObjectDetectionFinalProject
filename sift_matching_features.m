pfx = fullfile(vl_root,'data', 'roofs1.jpg') ; 
I = imread(pfx) ;
figure; image(I) ;
Ia = single(rgb2gray(I)) ;

pfx = fullfile(vl_root,'data', 'roofs2.jpg') ; 
I = imread(pfx) ;
figure, image(I) ;
Ib = single(rgb2gray(I)) ;

[fa, da] = vl_sift(Ia) ; %Computes SIFT features and descriptors
[fb, db] = vl_sift(Ib) ; %Computes SIFT features and descriptors
[matches, scores] = vl_ubcmatch(da, db) ; %function that finds matching descriptors by computing distances between descriptors da and db.

m1= fa(1:2,matches(1,:)); m2=fb(1:2,matches(2,:)); %Stores the x and y location of the features
m2(1,:)= m2(1,:)+size(Ia,2)*ones(1,size(m2,2)); %Updates the x location of features in second image because we want to show these images side by side

X=[m1(1,:);m2(1,:)]; 
Y=[m1(2,:);m2(2,:)];
c=[Ia Ib];
figure, imshow(c,[]);
hold on;
line(X(:,1:3:100),Y(:,1:3:100)) %Draws a line between every 3rd feature in the first 100 features
	
%TODO 1: PLAY with optional parameters in vl_sift that affect the number of features. "help vl_sift" will show two parameters 'PeakThresh' and 'edgeThresh' that can be changed.
%TODO 1: Use vl_plotframe to visualize features (like in sift_visualize_features.m)
	
%TODO 2: PLAY with optional parameters in vl_ubcmatch that affect the number of matches.  "help vl_ubcmatch" will show one threshold parameter that can be tweaked to change the number of matches.
%TODO 2: 

%TODO 3. PLAY with changing images. Images are in directory (vl_root,'data'). Try 'river1.jpg' and 'river2.jpg'