RGB = imread('img/kodim23.png');
%imfinfo('img/kodim23.png')

%c = [1 1 1];
%r = [1 2 3];
%pixels = impixel(RGB,c,r);
%disp(pixels);


scale_down = imresize(RGB, 0.25, 'bicubic');

scale_nearest = imresize(scale, 4, 'nearest');
scale_bilinear = imresize(scale, 4, 'bilinear');
scale_bicubic = imresize(scale, 4, 'bicubic');


figure, imshow(RGB), title('Original');
figure, imshow(scale_nearest), title('Nearest');
figure, imshow(scale_bilinear), title('Bilinear');
figure, imshow(scale_bicubic), title('Bicubic');
