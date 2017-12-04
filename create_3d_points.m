% Expecting MatchedPairs and Ia and Ib to be populated
%            c
%           /\
%          /c \
%         /    \
%        /      \
%     B /        \ A
%      /          \
%     /            \
%    /              \
%   /                \
%  /a________________b\
%           C

%we are assuming cameras are next to eachother on the x axis

%first calculate the angle of features from the camera
%we need the focal length of the camera, f. we will just 
%make that an arbitrary constant for now
f = 400 ;
midx = size(Ia, 1) ;
img1Theta = atan((MatchedPairs(1, :) - midx)/f);
img2Theta = atan((MatchedPairs(3, :) - midx)/f);

a = -img1Theta + (pi/2) ;
b = img2Theta + (pi/2) ;
c = -(a+b) + pi ;



%we will approximate distance: D = 1/p where p is the parallax angle
%
p = c/2 ;
D = p.^-1 ;
Features3D= [MatchedPairs(1:2, :); D] ;


%display
X = Features3D(1, :);
Y = Features3D(2, :);
Z = Features3D(3, :);


[xq,yq] = meshgrid(0:10:size(Ia,2),0:10:size(Ia,2))  ;
vq = griddata(X,Y,Z,xq,yq);
mesh(xq,yq,vq)
hold on
scatter3(X,Y,Z, 'r')

%interpolate with scatteredInterpolant?

%HeightImg = scatteredInterpolant(X', Y', Z');
%imshow(HeightImg)
