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

% SSIM file names
%ssim_file_rgb = 'ssim/ssim_planetearth2_bilinear_rgb.png';
%ssim_file_ycbcr = 'ssim/ssim_planetearth2_bilinear_ycbcr.png';

% Scale down
scale_factor = 4;
scaled_down_rgb = imresize(RGB, (1/scale_factor), 'bicubic');
scaled_down_ycbcr = imresize(YCbCr_422, (1/scale_factor), 'bicubic');

% Bilinear upscaling RGB
self_bilinear_rgb = bilinear(scaled_down_rgb, scale_factor);
matlab_bilinear_rgb = imresize(scaled_down_rgb, scale_factor, 'bilinear');

% Bilinear upscaling YCbCr
self_bilinear_ycbcr = bilinear(scaled_down_ycbcr, scale_factor);
matlab_bilinear_ycbcr = imresize(scaled_down_ycbcr, scale_factor, 'bilinear');

% Calculate Peak Sgnal-to-Noise Ratio
[PSNR_matlab_rgb, SNR_matlab_rgb] = psnr(matlab_bilinear_rgb, RGB);
[PSNR_matlab_ycbcr, SNR_matlab_ycbcr] = psnr(matlab_bilinear_ycbcr, YCbCr_422);
[PSNR_self_rgb, SNR_self_rgb] = psnr(self_bilinear_rgb, RGB);
[PSNR_self_ycbcr, SNR_self_ycbcr] = psnr(self_bilinear_ycbcr, YCbCr_422);
fprintf("-----------------------------------------\n");
fprintf("PSNR Matlab RGB: %0.4f\nPSNR Self RGB: %0.4f\n", PSNR_matlab_rgb, PSNR_self_rgb);
fprintf("PSNR Matlab YCbCr: %0.4f\nPSNR Self YCbCr: %0.4f\n", PSNR_matlab_ycbcr, PSNR_self_ycbcr);

% Calculate Mean-Squared Error
MSE_matlab_rgb = immse(matlab_bilinear_rgb, RGB);
MSE_self_rgb = immse(self_bilinear_rgb, RGB);
MSE_matlab_ycbcr = immse(matlab_bilinear_ycbcr, YCbCr_422);
MSE_self_ycbcr = immse(self_bilinear_ycbcr, YCbCr_422);
fprintf("-----------------------------------------\n");
fprintf("MSR Matlab RGB: %0.4f\nMSR Self RGB: %0.4f\n", MSE_matlab_rgb, MSE_self_rgb);
fprintf("MSR Matlab YCbCr: %0.4f\nMSR Self YCbCr: %0.4f\n", MSE_matlab_ycbcr, MSE_self_ycbcr);

% Calculate Structural Similarity SSIM
[mssim_matlab_rgb, ssim_map_matlab_rgb] = ssim(matlab_bilinear_rgb, RGB);
[mssim_matlab_ycbcr, ssim_map_matlab_ycbcr] = ssim(matlab_bilinear_ycbcr, YCbCr_422);
[mssim_self_rgb, ssim_map_self_rgb] = ssim(self_bilinear_rgb, RGB);
[mssim_self_ycbcr, ssim_map_self_ycbcr] = ssim(self_bilinear_ycbcr, YCbCr_422);
fprintf("-----------------------------------------\n");
fprintf("SSIM Matlab RGB: %0.4f\nSSIM Self RGB: %0.4f\n", mssim_matlab_rgb, mssim_self_rgb);
fprintf("SSIM Matlab YCbCr: %0.4f\nSSIM Self YCbCr: %0.4f\n", mssim_matlab_ycbcr, mssim_self_ycbcr);

% Write SSIM map to file
%imwrite(ssim_map_self_rgb, ssim_file_rgb);
%imwrite(ssim_map_self_ycbcr, ssim_file_ycbcr);

% Plot figures
figure();

subplot(4,3,1);imshow(RGB);title(sprintf('Original RGB'));
subplot(4,3,2);imshow(matlab_bilinear_rgb);title(sprintf('Matlab bilinear RGB\nPSNR = %0.4f\nMSE = %0.4f',PSNR_matlab_rgb, MSE_matlab_rgb));
subplot(4,3,3);imshow(self_bilinear_rgb);title(sprintf('Self bilinear RGB\nPSNR = %0.4f\nMSE = %0.4f',PSNR_self_rgb, MSE_self_rgb));


subplot(4,3,5);imshow(ssim_map_matlab_rgb,[]);title(sprintf('SSIM map Matlab bilinear RGB\nMean SSIM = %0.4f',mssim_matlab_rgb));
subplot(4,3,6);imshow(ssim_map_self_rgb,[]);title(sprintf('SSIM map Self bilinear RGB\nMean SSIM = %0.4f',mssim_self_rgb));

subplot(4,3,7);imshow(ycbcr2rgb(YCbCr_422));title(sprintf('Original YCbCr 4:2:2'));
subplot(4,3,8);imshow(ycbcr2rgb(matlab_bilinear_ycbcr));title(sprintf('Matlab bilinear YCbCr 4:2:2\nPSNR = %0.4f\nMSE = %0.4f',PSNR_matlab_ycbcr, MSE_matlab_ycbcr));
subplot(4,3,9);imshow(ycbcr2rgb(self_bilinear_ycbcr));title(sprintf('Self bilinear YCbCr 4:2:2\nPSNR = %0.4f\nMSE = %0.4f',PSNR_self_ycbcr, MSE_self_ycbcr));


subplot(4,3,11);imshow(ssim_map_matlab_ycbcr,[]);title(sprintf('SSIM map Matlab bilinear YCbCr\nMean SSIM = %0.4f',mssim_matlab_ycbcr));
subplot(4,3,12);imshow(ssim_map_self_ycbcr,[]);title(sprintf('SSIM map Self bilinear YCbCr\nMean SSIM = %0.4f',mssim_self_ycbcr));


