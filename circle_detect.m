% circle detection

rgb = imread('imag_0001.jpg');
imshow(rgb);
diameter = 120;
gray_image = rgb2gray(rgb);
imshow(gray_image)
[centers,radii] = imfindcircles(rgb,[diameter-20 diameter+20],'ObjectPolarity','dark','Sensitivity',0.95);
h = viscircles(centers,radii);
