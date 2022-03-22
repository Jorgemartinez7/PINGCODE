% center of mass detection
close all;
clear all;

N = 1240;
xG = zeros(1,N);
yG = zeros(1,N);
rad = zeros(1,N);

for ii = 1:N
    if ii<10
        filename = strcat('TEST3-1000',num2str(ii),'.jpg');
    elseif (ii>9) && (ii<100)
        filename = strcat('TEST3-100',num2str(ii),'.jpg');
    elseif (ii>99)&& (ii<1000)
        filename = strcat('TEST3-10',num2str(ii),'.jpg'); 
    else
          filename = strcat('TEST3-1',num2str(ii),'.jpg');
    end
    filename
    rgb = imread(filename);
    %imshow(rgb);
    diameter = 30;
    gray_image = im2gray(rgb);
    %imshow(gray_image)
    [centers,radii] = imfindcircles(rgb,[diameter-20 diameter+20],'ObjectPolarity','dark','Sensitivity',0.86)
    %h = viscircles(centers,radii);
   for ii = 3:N
    if (length(centers)~=0)
        xG(ii) = centers(1); yG(ii) = centers(2);
        rad(ii) = radii(1);
    else
        xG(ii) = 2*xG(ii-1) - xG(ii-2); yG(ii) = 2*yG(ii-1) - yG(ii-2);
        rad(ii) = rad(ii);
    end 
   end
end
v(:,1) = floor((1:1:N));
v(:,2) = xG;
v(:,3) = yG;
v(:,4) = rad;
save('traj_G.txt','v','-ascii');
