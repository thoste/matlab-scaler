clear all;

% Red RGB picture
RGB_color = imread('img/random-colors.png');
RGB_birds = imread('img/kodim23.tif');

% Convert to YCbCr
YCbCr444_color = rgb2ycbcr(RGB_color);
YCbCr422_color = rgb2ycbcr422(RGB_color);

YCbCr444_birds = rgb2ycbcr(RGB_birds);
YCbCr422_birds = rgb2ycbcr422(RGB_birds);

% % Get pixel data
% c = [1 1 2 2 3 3];
% r = [1 2 1 2 1 2];
% 
% pixel_444 = impixel(YCbCr444_color,c,r);
% disp("YCbCr 4:4:4 values:");
% disp(pixel_444);
% 
% pixels_422 = impixel(YCbCr422_color,c,r);
% disp("YCbCr 4:2:2 values:");
% disp(pixels_422);

% Plot figures
figure();

subplot(2,3,1);imshow(RGB_color);title("Original");
subplot(2,3,2);imshow(ycbcr2rgb(YCbCr444_color));title("YCbCr 4:4:4");
subplot(2,3,3);imshow(ycbcr2rgb(YCbCr422_color));title("YCbCr 4:2:2");

subplot(2,3,4);imshow(RGB_birds);title("Original");
subplot(2,3,5);imshow(ycbcr2rgb(YCbCr444_birds));title("YCbCr 4:4:4");
subplot(2,3,6);imshow(ycbcr2rgb(YCbCr422_birds));title("YCbCr 4:2:2");