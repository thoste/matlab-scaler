%% Bilinear interpolation

function output_image = bilinear(input_image, scale_factor)
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

    % Calculate delta size for each step
    delta_x = (orig_width-1)/width;
    delta_y = (orig_height-1)/height;
    
    % Starting position
    x = 1;
    y = 1;

    % Run thourch each pixel in output image
    for i = 1:height
        y1 = floor(y);
        y2 = y1 + 1;
        for j = 1:width
            x1 = floor(x);
            x2 = x1 + 1;
            
            Ax_y1 = (x2 - x)*A(y1,x1) + (x - x1)*A(y1,x2);
            Ax_y2 = (x2 - x)*A(y2,x1) + (x - x1)*A(y2,x2);
            A_new(i,j) = (y2 - y)*Ax_y1 + (y - y1)*Ax_y2;
            
            Bx_y1 = (x2 - x)*B(y1,x1) + (x - x1)*B(y1,x2);
            Bx_y2 = (x2 - x)*B(y2,x1) + (x - x1)*B(y2,x2);
            B_new(i,j) = (y2 - y)*Bx_y1 + (y - y1)*Bx_y2;
            
            Cx_y1 = (x2 - x)*C(y1,x1) + (x - x1)*C(y1,x2);
            Cx_y2 = (x2 - x)*C(y2,x1) + (x - x1)*C(y2,x2);
            C_new(i,j) = (y2 - y)*Cx_y1 + (y - y1)*Cx_y2;
            
            x = x + delta_x; 
        end
        x = 1;
        y = y + delta_y;
    end

    % Combine colours into RGB image
    output_image = cat(3, A_new, B_new, C_new);
end