clear all;
addpath('functions');


% Input image arrays
R = [0.4 1 0; 0 1 1; 0.8 0.8 0.1 ];
G = [1 0.5 0; 0 0 1; 0.5 0.3 0.7];
B = [0.0 0.0 0; 1.0 1.0 0.2; 1.0 0.4 1];
RGB = cat(3, R, G, B);

scale_factor = 4;

% Bilinear upscaling RGB
self_bilinear_rgb = bilinear(RGB, scale_factor);
matlab_bilinear_rgb = imresize(RGB, scale_factor, 'bilinear');

figure();

subplot(2,2,1);imshow(RGB);title(sprintf('INPUT image'));
subplot(2,2,3);imshow(self_bilinear_rgb);title(sprintf('SELF image'));
subplot(2,2,4);imshow(matlab_bilinear_rgb);title(sprintf('MATLAB image'));

% figure; image(RGB); title('INPUT image')
% figure; image(self_bilinear_rgb); title('SELF image')
% figure; image(matlab_bilinear_rgb); title('MATLAB image')