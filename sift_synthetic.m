%% Create a synthetic image comprising of white square on black background
I = zeros(400,400);
I(100:300, 100:300) = 1.0;
I = single(I);
figure, imshow(I,[]); impixelinfo

% Let us define a keypoint at the corner of the square 
x = 100;
y = 100;
scale = 10;
ang = 0;
% Format elements of a feature (x;y;scale,angle) in a 'frame' 
fc = [x;y;scale;ang];
[f,d] = vl_sift(I,'frames',fc); %Computes the descriptor d for a specific keypoint given by fc

%% Plot the 128-dimensional SIFT descriptor on top of Figure 1 
h = vl_plotsiftdescriptor(d,f);
set(h,'color','g');
disp(f);    % x,y,scale,angle
% figure, plot(d); 

%% Show the image at that scale, plot the gradient (using quiver) and the descriptor on top of the image. 
%To see the gradient directions, ZOOM into the image along the rectangle boundary
g = fspecial('gaussian', 6*scale, scale); 
Is = imfilter(I,g);
figure, imshow(Is,[]);
[gx,gy] = gradient(Is);
x = 1:size(I,2);
y = 1:size(I,1);
hold on
quiver(x, y, gx, gy);
h = vl_plotsiftdescriptor(d,f); set(h,'color','g'); %Note size of descriptor = 4*scale*MAGNIF (4 spatial bins * scale of keypoint * 3 which the magnification factor defined in library)