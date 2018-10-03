clear variables;
addpath('functions');

RGB = imread('img/IMG0023.tif');
%RGB = imread('img/LionKing.png');
%RGB = imread('img/link.png');
%RGB = imread('img/random-colors.png');
%imfinfo('img/IMG0023.png')

%c = [1 1 1];
%r = [1 2 3];
%pixels = impixel(RGB,c,r);
%disp(pixels);

%Scale down
scale_down = imresize(RGB, 0.25, 'bicubic');

% Scale up
scale_nearest = imresize(scale_down, 4, 'nearest');
scale_bilinear = imresize(scale_down, 4, 'bilinear');
scale_bicubic = imresize(scale_down, 4, 'bicubic');

% Peak Signal-to-noise ratio and Signal-to-noise ratio
[psnr_nearest, snr_nearest] = psnr(scale_nearest, RGB);
[psnr_bilinear, snr_bilinear] = psnr(scale_bilinear, RGB);
[psnr_bicubic, snr_bicubic] = psnr(scale_bicubic, RGB);
fprintf("PSNR\nNearest: %f\nBilinear: %f\nBicubic: %f\n", psnr_nearest, psnr_bilinear, psnr_bicubic);

% Structural Similarity SSIM
[mssim_nearest, ssim_map_nearest] = ssim(scale_nearest, RGB);
[mssim_bilinear, ssim_map_bilinear] = ssim(scale_bilinear, RGB);
[mssim_bicubic, ssim_map_bicubic] = ssim(scale_bicubic, RGB);
fprintf("SSIM\nNearest: %f\nBilinear: %f\nBicubic: %f\n", mssim_nearest, mssim_bilinear, mssim_bicubic);

% Figure
figure()
subplot(2,3,1), imshow(scale_nearest), title(sprintf('Nearest\nPSNR = %f',psnr_nearest));
subplot(2,3,2), imshow(scale_bilinear), title(sprintf('Bilinear\nPSNR = %f',psnr_bilinear));
subplot(2,3,3), imshow(scale_bicubic), title(sprintf('Bicubic\nPSNR = %f',psnr_bicubic));

subplot(2,3,4);imshow(ssim_map_nearest,[]);title(sprintf('SSIM map Nearest\nMean SSIM = %f',mssim_nearest));
subplot(2,3,5);imshow(ssim_map_bilinear,[]);title(sprintf('SSIM map Bilinear\nMean SSIM = %f',mssim_bilinear));
subplot(2,3,6);imshow(ssim_map_bicubic,[]);title(sprintf('SSIM map Self Bicubic\nMean SSIM = %f',mssim_bicubic));
