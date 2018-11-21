clear variables;
addpath('functions');

scale_factor = 4;

% Get image
RGB = imread('img/natural/Two Macaws.tif');
YCbCr_422 = rgb2ycbcr422(RGB);

% Pre scale
prescaled_rgb = imresize(RGB, (1/scale_factor), 'bicubic');
prescaled_ycbcr = imresize(YCbCr_422, (1/scale_factor), 'bicubic');

% Scale
scaled_rgb = interpolate(prescaled_rgb, scale_factor, 'bicubic');
scaled_ycbcr = interpolate(prescaled_ycbcr, scale_factor, 'bicubic');

% Figure
figure();

subplot(2,2,1);imshow(RGB);title(sprintf('RGB Original'));
subplot(2,2,2);imshow(ycbcr2rgb(YCbCr_422));title(sprintf('YCbCr 4:2:2 Original'));
subplot(2,2,3);imshow(scaled_rgb);title(sprintf('RGB scaled'));
subplot(2,2,4);imshow(ycbcr2rgb(scaled_ycbcr));title(sprintf('YCbCr 4:2:2 scaled'));
