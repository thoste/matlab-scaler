clear all;
addpath('functions');


% RGB image array
R = uint8([255 255 255 255; 0 128 128 255; 51 0 0 0; 255 0 255 255]);
G = uint8([0 128 255 0; 0 255 128 128; 255 204 128 0; 255 0 255 128]);
B = uint8([0 0 0 255; 0 0 128 0; 255 0 255 0; 0 255 255 0]);
RGB = cat(3, R, G, B);

scale_factor = 4;

% Bilinear upscaling RGB
matlab_bilinear = imresize(RGB, scale_factor, 'bilinear');
self_bilinear = bilinear(RGB, scale_factor);
self_bilinear2 = bilinear2(RGB, scale_factor);


% Plot figure
figure();

subplot(2,2,1);imshow(RGB);title(sprintf('Original'));
subplot(2,2,2);imshow(matlab_bilinear);title(sprintf('Matlab bilinear'));
subplot(2,2,3);imshow(self_bilinear);title(sprintf('Self bilinear'));
subplot(2,2,4);imshow(self_bilinear2);title(sprintf('Self bilinear2'));

