%% Run this file to visualize 50 random keypoints on the image roof1.jpg

pfx = fullfile(vl_root,'data', 'roofs1.jpg') ; 
I = imread(pfx) ;
figure, image(I) ;
I = single(rgb2gray(I)) ;
[f,d] = vl_sift(I) ; %Computes features f using the DOG method and the corresponding descriptors in d

perm = randperm(size(f,2)) ;
sel = perm(1:50) ;

%Plot the scale of the feature in a yellow circle
h1 = vl_plotframe(f(:,sel)) ; 
h2 = vl_plotframe(f(:,sel)) ; set(h1,'color','k','linewidth',3) ; set(h2,'color','y','linewidth',2) ;

%Plot the descriptor in green square
h3 = vl_plotsiftdescriptor(d(:,sel),f(:,sel)) ; set(h3,'color','g')