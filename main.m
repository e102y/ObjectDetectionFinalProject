clc
close all
scale = 1 ; %how is the image scaled?
%sourceimage url is http://vision.middlebury.edu/stereo/submit3/zip/MiddEval3-data-F.zip
<<<<<<< Updated upstream
num = 9 ; %4,5 are good; 6(good) versus 7(bad) shows lighting effect. 
=======
num = 4 ;
>>>>>>> Stashed changes
numberString = int2str(num) ;

pfx = fullfile('Images', 'trainingQ', numberString, {'im0.png', 'im1.png'}) ;

image = imread(char(pfx(:,1))) ;
image1 = imresize(image, scale) ;
image = imread(char(pfx(:,2))) ;
image2 = imresize(image, scale) ;
figure, imshow(image1);
figure, imshow(image2);


matchedPoints = generateMatchedPoints(image1, image2);

%%
%should get MatchedPairs
depthmap = generateDepthMap(image1, matchedPoints);
newimg  = rgb2hsDMv(image1, depthmap);
