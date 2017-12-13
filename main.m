scale = 0.3 ; %how is the image scaled?

pfx = fullfile('Images', 'storage0.png') ; 
image = imread(pfx) ;
image1 = imresize(image, scale) ;

pfx = fullfile('Images', 'storage1.png') ; 
image = imread(pfx) ;
image2 = imresize(image, scale) ;

matchedPoints = generateMatchedPoints(image1, image2);
%should get MatchedPairs
depthmap = generateDepthMap(image1, matchedPoints);
