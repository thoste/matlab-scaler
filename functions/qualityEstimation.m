
function quality = qualityEstimation(RGB_file, algorithm, method, scale_factor, matlab_AA_filter)
    RGB = imread(RGB_file);
    
    % Convert 16-bit RGB to 8-bit
    if isa(RGB,'uint16')
        fprintf('Converting uint16 to uint8\n');
        RGB = uint8(RGB/256);
    end
    
    YCbCr_422 = rgb2ycbcr422(RGB);
    
    % Pre scale
    prescaled_rgb = imresize(RGB, (1/scale_factor), 'bicubic');
    prescaled_ycbcr = imresize(YCbCr_422, (1/scale_factor), 'bicubic');
    
    % Convert from 4:4:4 back to 4:2:2 after scaling
    prescaled_ycbcr = ycbcr2ycbcr422(prescaled_ycbcr);
    
    % Scale
    switch algorithm
        case 'self'
            scaled_rgb = interpolate(prescaled_rgb, scale_factor, method);
            scaled_ycbcr = interpolate(prescaled_ycbcr, scale_factor, method);
        case 'matlab'
            scaled_rgb = imresize(prescaled_rgb, scale_factor, method, 'Antialiasing', matlab_AA_filter);
            scaled_ycbcr = imresize(prescaled_ycbcr, scale_factor, method, 'Antialiasing', matlab_AA_filter);
        otherwise
            % Default is to use own algorithm
            scaled_rgb = interpolate(prescaled_rgb, scale_factor, method);
            scaled_ycbcr = interpolate(prescaled_ycbcr, scale_factor, method);
    end
    
    % Convert from 4:4:4 back to 4:2:2 after scaling
    scaled_ycbcr = ycbcr2ycbcr422(scaled_ycbcr);

    % Calculate PSN and SNR
    [PSNR_rgb, SNR_rgb] = psnr(scaled_rgb, RGB);
    [PSNR_ycbcr, SNR_ycbcr] = psnr(scaled_ycbcr, YCbCr_422);
    
    % Calculate MSE
    MSE_rgb = immse(scaled_rgb, RGB);
    MSE_ycbcr = immse(scaled_ycbcr, YCbCr_422);
    
    % Calulate SSIM
    [mssim_rgb, ssim_self_rgb] = ssim(scaled_rgb, RGB);
    [mssim_ycbcr, ssim_self_ycbcr] = ssim(scaled_ycbcr, YCbCr_422);
    
    % Replace folder name
    old_folder = 'img';
    new_folder = 'ssim';
    new_path = replace(RGB_file,old_folder,new_folder);
 
    % Replace file name
    old_file = {'.tif', '.png'};
    if scale_factor < 1
        new_file_rgb = strcat('_ssim_rgb_',algorithm,'_',method,'_downscale.png');
        new_file_ycbcr = strcat('_ssim_ycbcr_',algorithm,'_',method,'_downscale.png');
    else
        new_file_rgb = strcat('_ssim_rgb_',algorithm,'_',method,'_upscale.png');
        new_file_ycbcr = strcat('_ssim_ycbcr_',algorithm,'_',method,'_upscale.png');
    end
    ssim_rgb_file = replace(new_path, old_file, new_file_rgb);
    ssim_ycbcr_file = replace(new_path, old_file, new_file_ycbcr);
    
    % Write SSIM map to PNG image
    %imwrite(ssim_self_rgb, ssim_rgb_file);
    %imwrite(ssim_self_ycbcr, ssim_ycbcr_file);   
    
    % Return quality metrics
    quality = {"PSNR-RGB", PSNR_rgb;
        "PSNR-YCbCr", PSNR_ycbcr;
        "SNR-RGB", SNR_rgb;
        "SNR-YCbCr", SNR_ycbcr;
        "MSE-RGB", MSE_rgb;
        "MSE-YCbCr", MSE_ycbcr;
        "SSIM-RGB", mssim_rgb;
        "SSIM-YCbCr", mssim_ycbcr};  
end