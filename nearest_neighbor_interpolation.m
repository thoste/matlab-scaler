clear variables;
addpath('functions');

% Get image
RGB = imread('img/kodim23.tif');
%RGB = getSingleFrame('video/sony4k.mp4',1);
YCbCr_422 = rgb2ycbcr422(RGB);

% Scale down
scale_factor = 4;
scaled_down_rgb = imresize(RGB, (1/scale_factor), 'bicubic');
scaled_down_ycbcr = imresize(YCbCr_422, (1/scale_factor), 'bicubic');

% Nearest neighbor upscaling RGB
self_nearest = nearest(scaled_down_rgb, scale_factor);
matlab_nearest = imresize(scaled_down_rgb, scale_factor, 'nearest');


% Nearest neighbor upscaling YCbCr
self_nearest_ycbcr = nearest(scaled_down_ycbcr, scale_factor);
matlab_nearest_ycbcr = imresize(scaled_down_ycbcr, scale_factor, 'nearest');

% Calculate Peak Sgnal-to-Noise Ratio
[PSNR_matlab_rgb, SNR_matlab_rgb] = psnr(matlab_nearest, RGB);
[PSNR_matlab_ycbcr, SNR_matlab_ycbcr] = psnr(matlab_nearest_ycbcr, YCbCr_422);
[PSNR_self_rgb, SNR_self_rgb] = psnr(self_nearest, RGB);
[PSNR_self_ycbcr, SNR_self_ycbcr] = psnr(self_nearest_ycbcr, YCbCr_422);


fprintf("PSNR Matlab RGB: %f\nPSNR Matlab YCbCr: %f\n", PSNR_matlab_rgb, PSNR_matlab_ycbcr);
fprintf("PSNR Self RGB: %f\nPSNR Self YCbCr: %f\n", PSNR_self_rgb, PSNR_self_ycbcr);

% Plot figures
figure();

subplot(2,3,1);imshow(RGB);title("Original RGB");
subplot(2,3,2);imshow(matlab_nearest);title("Matlab nearest RGB");
subplot(2,3,3);imshow(self_nearest);title("Self nearest RGB");

subplot(2,3,4);imshow(ycbcr2rgb(YCbCr_422));title("Original YCbCr");
subplot(2,3,5);imshow(ycbcr2rgb(matlab_nearest_ycbcr));title("Matlab nearest YCbCr 4:2:2");
subplot(2,3,6);imshow(ycbcr2rgb(self_nearest_ycbcr));title("Self nearest YCbCr 4:2:2");

