function hsDMv = rgb2hsDMv(image, dm)

%IMG = image;

%for orginal testing
%IMG = imresize(IMG, 0.05) ;

%convert to hsv
img = rgb2hsv(image);
%%%
figure, imshow(img);
%compress hue and saturation into one channel
sat = img(:, :, 2) ;
hue = img(:, :, 1) ;
avg = (sat + hue)/2 ;
img(:, :, 1) = avg ;

%%
%filled with zeros until we have the depth map.
%dimensions 
x = size(img(:,:,1)) ;
%dimensions = [dimensions, 0] ;
img(:, :, 2) = double(zeros(x)) ;

figure, imshow(img);
img(:, :, 2) = dm*2.3 ;


figure, imshow(img);
hsDMv = img;