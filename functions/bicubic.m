%% Bilinear interpolation

function output_image = bicubic(input_image, scale_factor)
    % Separate each colour value from input image
    A = input_image(:,:,1);
    B = input_image(:,:,2);
    C = input_image(:,:,3);

    % Calculate size of input image
    [orig_height,orig_width] = size(A);

    % Allocate output image with new size
    height = ceil(orig_height * scale_factor);
    width = ceil(orig_width * scale_factor);
    bit = class(input_image);
    A_new = zeros(height,width,bit);
    B_new = zeros(height,width,bit);
    C_new = zeros(height,width,bit);

    height_scale = (orig_height/height);
    width_scale = (orig_width/width);
    
    a = -0.5;
    
    % Run thourch each pixel in output image
    for i = 1:height
        y = (height_scale * i) + (0.5 * (1 - 1/scale_factor));
        for j = 1:width
            x = (width_scale * j) + (0.5 * (1 - 1/scale_factor));
            
            x(x < 1) = 1;
            x(x >= orig_width) = orig_width;
            y(y < 1) = 1;
            y(y >= orig_height) = orig_height;
            
            for u = i-1:i+2
                for v = j-1:j+2
                    u(u < 1) = 1;
                    u(u >= orig_width) = orig_width;
                    v(v < 1) = 1;
                    v(v >= orig_height) = orig_height;
                    
                    W_bicubic = cubicFormula(a,(y-u)) * cubicFormula(a,(x-v));
                    %fprintf('u: %d v: %d \n',u,v);
                    A_new(i,j) = A_new(i,j) + (A(u,v)*W_bicubic);
                    B_new(i,j) = B_new(i,j) + (B(u,v)*W_bicubic);
                    C_new(i,j) = C_new(i,j) + (C(u,v)*W_bicubic);
                end
            end

        end
    end

    % Combine colours into RGB image
    output_image = cat(3, A_new, B_new, C_new);
end