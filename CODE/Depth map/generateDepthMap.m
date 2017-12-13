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
function returnedValue = generateDepthMap(image, MatchedPairs)

Ia = image ;
f = 100 ;
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
D = (D/200)./((D/200)+1) ;
Features3D= [MatchedPairs(1:2, :); D] ;
maxD = max(D);
Features3D= [Features3D, [0;0;maxD], [0;size(Ia,1);maxD], [size(Ia,2);0;maxD], [size(Ia,2);size(Ia,1);maxD]];

%display
X = Features3D(1, :) ;
Y = Features3D(2, :) ;
Z = Features3D(3, :) ;


[xq,yq] = meshgrid(0:1:size(Ia,2)-1,0:1:size(Ia,1)-1)  ;
vq = griddata(X,Y,Z,xq,yq);

figure, mesh(xq,yq,vq)
hold on
scatter3(X,Y,Z, 'r')
hold off

figure, imshow(vq, [0,1])
returnedValue = vq ;
return ;

%bilinear interpolation
%interpolate with scatteredInterpolant?

%HeightImg = scatteredInterpolant(X', Y', Z');
%imshow(HeightImg)

%{
matchedPoints1 = MatchedPairs(1:2) ;
matchedPoints2 = MatchedPairs(3:4) ;
triangulate(matchedPoints1, matchedPoints2, camMatrix1, camMatrix2);
%}