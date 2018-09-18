clear all;

RGB = imread('img/IMG0023.tif');
%imfinfo('img/kodim23.png')

%c = [1 1 1];
%r = [1 2 3];
%pixels = impixel(RGB,c,r);
%disp(pixels);


scale_down = imresize(RGB, 0.25, 'bicubic');

scale_nearest = imresize(scale_down, 4, 'nearest');
scale_bilinear = imresize(scale_down, 4, 'bilinear');
scale_bicubic = imresize(scale_down, 4, 'bicubic');


figure()
subplot(2,2,1), imshow(RGB), title('Original');
subplot(2,2,2), imshow(scale_nearest), title('Nearest');
subplot(2,2,3), imshow(scale_bilinear), title('Bilinear');
subplot(2,2,4), imshow(scale_bicubic), title('Bicubic');
