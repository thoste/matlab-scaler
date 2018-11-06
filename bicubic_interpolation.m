clear all;
%clc;
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
scale_factor = 4;
pre_scale_rgb = imresize(RGB, (1/scale_factor), 'bicubic');
pre_scale_ycbcr = imresize(YCbCr_422, (1/scale_factor), 'bicubic');

% Bilinear upscaling RGB
matlab_rgb = imresize(pre_scale_rgb, scale_factor, 'bicubic');
self_rgb = bicubic(pre_scale_rgb, scale_factor);



% Calculate Peak Sgnal-to-Noise Ratio
[PSNR_matlab_rgb, SNR_matlab_rgb] = psnr(matlab_rgb, RGB);
[PSNR_self_rgb, SNR_self_rgb] = psnr(self_rgb, RGB);
fprintf("-----------------------------------------\n");
fprintf("PSNR Matlab RGB: %0.4f\nPSNR Self RGB: %0.4f\n", PSNR_matlab_rgb, PSNR_self_rgb);

% Calculate Mean-Squared Error
MSE_matlab_rgb = immse(matlab_rgb, RGB);
MSE_self_rgb = immse(self_rgb, RGB);
fprintf("-----------------------------------------\n");
fprintf("MSE Matlab RGB: %0.4f\nMSE Self RGB: %0.4f\n", MSE_matlab_rgb, MSE_self_rgb);

% Calculate Structural Similarity SSIM
[mssim_matlab_rgb, ssim_map_matlab_rgb] = ssim(matlab_rgb, RGB);
[mssim_self_rgb, ssim_map_self_rgb] = ssim(self_rgb, RGB);
fprintf("-----------------------------------------\n");
fprintf("SSIM Matlab RGB: %0.4f\nSSIM Self RGB: %0.4f\n", mssim_matlab_rgb, mssim_self_rgb);

% Plot figures
figure();

subplot(2,2,1);imshow(matlab_rgb);title(sprintf('Matlab bicubic RGB\nPSNR = %0.4f\nMSE = %0.4f',PSNR_matlab_rgb, MSE_matlab_rgb));
subplot(2,2,2);imshow(self_rgb);title(sprintf('Self bicubic RGB\nPSNR = %0.4f\nMSE = %0.4f',PSNR_self_rgb, MSE_self_rgb));

subplot(2,2,3);imshow(ssim_map_matlab_rgb,[]);title(sprintf('SSIM map Matlab bicubic RGB\nMean SSIM = %0.4f',mssim_matlab_rgb));
subplot(2,2,4);imshow(ssim_map_self_rgb,[]);title(sprintf('SSIM map Self bicubic RGB\nMean SSIM = %0.4f',mssim_self_rgb));

