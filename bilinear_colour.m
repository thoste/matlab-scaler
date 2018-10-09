clear all;
addpath('functions');


% Input image arrays
select = 1;
if select == 1
    R = [0.4 1 0; 0 1 1; 0.8 0.8 0.1 ];
    G = [1 0.5 0; 0 0 1; 0.5 0.3 0.7];
    B = [0.0 0.0 0; 1.0 1.0 0.2; 1.0 0.4 1];
elseif select == 2
    R = [0.4 1 0 0; 0 1 1 1; 0.8 0.8 0.1 0.1];
    G = [1 0.5 0 0; 0 0 1 1; 0.5 0.3 0.7 0.7];
    B = [0.0 0.0 0 0; 1.0 1.0 0.2 0.2; 1.0 0.4 1 1];
else
    R = [0.4 1 0 0; 0 1 1 1; 0.8 0.8 0.1 0.1; 0.4 1 0 0];
    G = [1 0.5 0 0; 0 0 1 1; 0.5 0.3 0.7 0.7; 1 0.5 0 0];
    B = [0.0 0.0 0 0; 1.0 1.0 0.2 0.2; 1.0 0.4 1 1; 0.0 0.0 0 0];
end
RGB = cat(3, R, G, B);

scale_factor = 2;

% Bilinear upscaling RGB
matlab_bilinear = imresize(RGB, scale_factor, 'bilinear');
self_bilinear = bilinear(RGB, scale_factor);
self_bilinear2 = bilinear2(RGB, scale_factor);


% Plot figure
figure();

subplot(2,2,1);imshow(RGB);title(sprintf('Original'));
subplot(2,2,2);imshow(matlab_bilinear);title(sprintf('Matlab bilinear'));
subplot(2,2,3);imshow(self_bilinear);title(sprintf('Self bilinear'));
subplot(2,2,4);imshow(self_bilinear2);title(sprintf('Self bilinear2'));

