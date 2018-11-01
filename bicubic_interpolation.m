clear all;
addpath('functions');

% Get image
RGB = imread('img/natural/TwoMacaws.tif');

% Convert 16-bit RGB to 8-bit
if isa(RGB,'uint16')
    fprintf('Converting uint16 to uint8\n');
    RGB = uint8(RGB/256);
end

% Create YCbCr 4:2:2 image
YCbCr_422 = rgb2ycbcr422(RGB);

% Scale down
scale_factor = 0.25;
pre_scale_rgb = imresize(RGB, (1/scale_factor), 'bicubic');
pre_scale_ycbcr = imresize(YCbCr_422, (1/scale_factor), 'bicubic');

% Bilinear upscaling RGB
matlab_bicubic_rgb = imresize(pre_scale_rgb, scale_factor, 'bicubic');
self_bicubic_rgb = bicubic2(pre_scale_rgb, scale_factor);


% Plot figures
figure();

subplot(2,2,1);imshow(matlab_bicubic_rgb);title(sprintf('Matlab bicubic'));
subplot(2,2,2);imshow(self_bicubic_rgb);title(sprintf('Self bicubic'));
