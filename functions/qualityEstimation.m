
function quality = qualityEstimation(RGB_file, algorithm)
    RGB = imread(RGB_file);
    
    % Convert 16-bit RGB to 8-bit
    if isa(RGB,'uint16')
        fprintf('Converting uint16 to uint8\n');
        RGB = uint8(RGB/256);
    end
    
    YCbCr_422 = rgb2ycbcr422(RGB);
    
    % Scale down
    scale_factor = 4;
    scaled_down_rgb = imresize(RGB, (1/scale_factor), 'bicubic');
    scaled_down_ycbcr = imresize(YCbCr_422, (1/scale_factor), 'bicubic');
    
    % Scale up
    switch algorithm
        case 'nearest'
            self_rgb = nearest(scaled_down_rgb, scale_factor);
            self_ycbcr = nearest(scaled_down_ycbcr, scale_factor);
        case 'bilinear'
            self_rgb = nearest(scaled_down_rgb, scale_factor);
            self_ycbcr = nearest(scaled_down_ycbcr, scale_factor);
        case 'bicubic'
            self_rgb = nearest(scaled_down_rgb, scale_factor);
            self_ycbcr = nearest(scaled_down_ycbcr, scale_factor);
        otherwise
            % Do nothing
    end

    % Calculate PSN and SNR
    [PSNR_self_rgb, SNR_self_rgb] = psnr(self_rgb, RGB);
    [PSNR_self_ycbcr, SNR_self_ycbcr] = psnr(self_ycbcr, YCbCr_422);
    
    % Calculate MSE
    MSE_self_rgb = immse(self_rgb, RGB);
    MSE_self_ycbcr = immse(self_ycbcr, YCbCr_422);
    
    % Calulate SSIM
    [mssim_self_rgb, ssim_map_self_rgb] = ssim(self_rgb, RGB);
    [mssim_self_ycbcr, ssim_map_self_ycbcr] = ssim(self_ycbcr, YCbCr_422);
    
    % Replace folder name
    old = 'img';
    new = 'ssim';
    new_folder = replace(RGB_file,old,new);
 
    % Replace file name
    old2 = {'.tif', '.png'};
    new2 = '_ssim_rgb_';
    new3 = '_ssim_ycbcr_';
    ssim_rgb_file = replace(new_folder, old2, new2);
    ssim_rgb_file = strcat(ssim_rgb_file,algorithm,'.png');
    ssim_ycbcr_file = replace(new_folder, old2, new3);
    ssim_ycbcr_file = strcat(ssim_ycbcr_file,algorithm,'.png');
    
    
    % Write SSIM map to PNG image
    imwrite(ssim_map_self_rgb, ssim_rgb_file);
    imwrite(ssim_map_self_ycbcr, ssim_ycbcr_file);
    
    % Return quality metrics
    quality = {"PSNR-RGB", PSNR_self_rgb;
        "PSNR-YCbCr", PSNR_self_ycbcr;
        "SNR-RGB", SNR_self_rgb;
        "SNR-YCbCr", SNR_self_ycbcr;
        "MSE-RGB", MSE_self_rgb;
        "MSE-YCbCr", MSE_self_ycbcr;
        "SSIM-RGB", mssim_self_rgb;
        "SSIM-YCbCr", mssim_self_ycbcr};
end