
Disparity cv reprojectImageTo3D

%Compute Disparity Map for a Pair of Stereo Images
%Load the images and convert them to grayscale.
I1 = imread('scene_left.png');
I2 = imread('scene_right.png');

%Show stereo anaglyph. Use red-cyan stereo glasses to view image in 3-D.
figure
imshow(stereoAnaglyph(I1,I2));
title('Red-cyan composite view of the stereo images');

%Compute the disparity map.
disparityRange = [-6 10];
disparityMap = disparity(rgb2gray(I1),rgb2gray(I2),'BlockSize',...
    15,'DisparityRange',disparityRange);

%Display the disparity map. For better visualization, use the disparity range as the display range for imshow.
figure 
imshow(disparityMap,disparityRange);
title('Disparity Map');
colormap(gca,jet) 
colorbar
%Copyright 2012 The MathWorks, Inc.



