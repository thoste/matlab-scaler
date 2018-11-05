clear all;
%clc;
addpath('functions');


% RGB image array
R = uint8([255 255 255 255; 0 128 128 255; 51 0 0 0; 255 0 255 255]);
G = uint8([0 128 255 0; 0 255 128 128; 255 204 128 0; 255 0 255 128]);
B = uint8([0 0 0 255; 0 0 128 0; 255 0 255 0; 0 255 255 0]);
RGB = cat(3, R, G, B);

scale_factor = 8;

% Upscaling RGB
matlab_nearest = imresize(RGB, scale_factor, 'nearest');
self_nearest = nearest(RGB, scale_factor);

matlab_bilinear = imresize(RGB, scale_factor, 'bilinear');
self_bilinear2 = bilinear(RGB, scale_factor);

matlab_bicubic = imresize(RGB, scale_factor, 'bicubic');
self_bicubic = bicubic(RGB, scale_factor);



% Plot figure
figure();

subplot(2,4,1);imshow(RGB);title(sprintf('Original'));
subplot(2,4,2);imshow(matlab_nearest);title(sprintf('Matlab nearest'));
subplot(2,4,3);imshow(matlab_bilinear);title(sprintf('Matlab bilinear'));
subplot(2,4,4);imshow(matlab_bicubic);title(sprintf('Matlab bicubic'));
subplot(2,4,6);imshow(self_nearest);title(sprintf('Self nearest'));
subplot(2,4,7);imshow(self_bilinear2);title(sprintf('Self bilinear'));
subplot(2,4,8);imshow(self_bicubic);title(sprintf('Self bicubic'));

