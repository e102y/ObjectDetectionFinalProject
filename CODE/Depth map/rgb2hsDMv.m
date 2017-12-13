function hsDMv = rgb2hsDMv(image, dm)

%IMG = image;

%for orginal testing
%IMG = imresize(IMG, 0.05) ;

%convert to hsv
img = rgb2hsv(image);
%%%
figure, imshow(img);
%%
%compress hue and saturation into one channel
sat = img(:, :, 2); %pull the saturation
hue = img(:, :, 1); %pull the hue
avg = (sat + hue)/2; %the the result and divide them by two
img(:, :, 1) = avg; %assign the new average into the first channel

%%
%filled with zeros until we have the depth map.
x = size(img(:,:,1)); %filling a 2-d array with zeros
%dimensions = [dimensions, 0] ;
img(:, :, 2) = double(zeros(x)); %replace the saturation layer with our depthmap
figure, imshow(img);
%%
%add in our depth map
img(:, :, 2) = dm*2.3;%this multiple by three is to help illustrate the results for imshow
figure, imshow(img);

%return
hsDMv = img/2.3;