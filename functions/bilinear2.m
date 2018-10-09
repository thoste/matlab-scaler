%% Bilinear interpolation

function output_image = bilinear2(input_image, scale_factor)
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
    
    % Run thourch each pixel in output image
    for i = 1:height
        y = (height_scale * i) + (0.5 * (1 - 1/scale_factor));
        for j = 1:width
            x = (width_scale * j) + (0.5 * (1 - 1/scale_factor));
            
            x(x < 1) = 1;
            if x >= orig_width
                x = orig_width;
                x1 = floor(x) - 1;
            else
                x1 = floor(x);
            end
            x2 = x1 + 1;
            
            y(y < 1) = 1;
            if y >= orig_height
                y = orig_height;
                y1 = floor(y) - 1;
            else
                y1 = floor(y);
            end
            y2 = y1 + 1;
            
            Ax_y1 = (x2 - x)*A(y1,x1) + (x - x1)*A(y1,x2);
            Ax_y2 = (x2 - x)*A(y2,x1) + (x - x1)*A(y2,x2);
            A_new(i,j) = (y2 - y)*Ax_y1 + (y - y1)*Ax_y2;
            
            Bx_y1 = (x2 - x)*B(y1,x1) + (x - x1)*B(y1,x2);
            Bx_y2 = (x2 - x)*B(y2,x1) + (x - x1)*B(y2,x2);
            B_new(i,j) = (y2 - y)*Bx_y1 + (y - y1)*Bx_y2;
            
            Cx_y1 = (x2 - x)*C(y1,x1) + (x - x1)*C(y1,x2);
            Cx_y2 = (x2 - x)*C(y2,x1) + (x - x1)*C(y2,x2);
            C_new(i,j) = (y2 - y)*Cx_y1 + (y - y1)*Cx_y2;
        end
    end

    % Combine colours into RGB image
    output_image = cat(3, A_new, B_new, C_new);
end