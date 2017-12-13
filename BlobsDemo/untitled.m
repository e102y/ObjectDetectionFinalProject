%file = '/desktop/IMG.png';
%img = imread(file);

IMG = imread('IMG.jpg') ;
IMG = imresize(IMG, 0.05) ;
img = rgb2hsv(IMG);

sat = img(:, :, 2) ;
hue = img(:, :, 1) ;

avg = (sat + hue)/2 ;
img(:, :, 1) = avg ;
%dimensions 
x = size(img(:,:,1)) ;
%dimensions = [dimensions, 0] ;
img(:, :, 2) = double(zeros(x)) ;

figure, imshow(img);