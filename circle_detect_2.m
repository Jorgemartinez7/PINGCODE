% circle detection


rgb = imread('TEST3-10000.jpg');
imshow(rgb);
diameter = 30;
gray_image = im2gray(rgb);
imshow(gray_image)
%delete(h);
[centers,radii] = imfindcircles(rgb,[diameter-20 diameter+20],'ObjectPolarity','bright','Sensitivity',0.82)
h = viscircles(centers,radii);
