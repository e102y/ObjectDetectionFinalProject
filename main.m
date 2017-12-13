pfx = fullfile('Images', 'storage0.png') ; 
image = imread(pfx) ;
image = imresize(image, scale) ;
matchedPoints = generateMatchedPoints(image);
%should get MatchedPairs
generateDepthMap(image, matchedPoints);
