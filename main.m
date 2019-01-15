clear all;
addpath('functions');

% Get image
RGB = imread('img/natural/Two Macaws.tif');

% Convert 16-bit RGB to 8-bit
if isa(RGB,'uint16')
    fprintf('Converting uint16 to uint8\n');
    RGB = uint8(RGB/256);
end

% Pre scaleing
scale_factor = 4;
pre_scale_rgb = imresize(RGB, (1/scale_factor), 'bicubic');

% Scaling RGB
nearest_rgb = nearest(pre_scale_rgb, scale_factor);
bilinear_rgb = bilinear(pre_scale_rgb, scale_factor);
bicubic_rgb = bicubic(pre_scale_rgb, scale_factor);

% Plot
figure();

subplot(2,2,1);imshow(RGB);title('Original');
subplot(2,2,2);imshow(nearest_rgb);title('Nearest');
subplot(2,2,3);imshow(bilinear_rgb);title('Bilinear');
subplot(2,2,4);imshow(bicubic_rgb);title('Bicubic');