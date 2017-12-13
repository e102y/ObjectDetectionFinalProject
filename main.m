scale = 1 ; %how is the image scaled?
%sourceimage url is http://vision.middlebury.edu/stereo/submit3/zip/MiddEval3-data-F.zip
num = 4 ; %4 is good; 6(good) versus 7(bad) shows lighting effect. 
numberString = int2str(num) ;

pfx = fullfile('Images', 'testQ', numberString, {'im0.png', 'im1.png'}) ;

image = imread(char(pfx(:,1))) ;
image1 = imresize(image, scale) ;
image = imread(char(pfx(:,2))) ;
image2 = imresize(image, scale) ;

depthmap = depthFromStereoImages(image1, image2);
newimg  = rgb2hsDMv(image1, depthmap);
