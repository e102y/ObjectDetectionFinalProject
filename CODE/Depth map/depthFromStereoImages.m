function returnValue = depthFromStereoImages(imageL, imageR)

returnValue = generateDepthMap(imageL, generateMatchedPoints(imageL,imageR)) ;
return