%% Bilinear interpolation

function output_image = bicubic(input_image, scale_factor)
    % Separate each colour value from input image
    A = input_image(:,:,1);
    B = input_image(:,:,2);
    C = input_image(:,:,3);

    % Calculate size of input image
    [orig_height,orig_width] = size(A);

    % Allocate output image with new size
    new_height = ceil(orig_height * scale_factor);
    new_width = ceil(orig_width * scale_factor);
    bit = class(input_image);
    A_new = zeros(new_height,new_width,bit);
    B_new = zeros(new_height,new_width,bit);
    C_new = zeros(new_height,new_width,bit);
    
    
    % Run thourch each pixel in output image
    for y_out = 1:new_height
        dy = (y_out/scale_factor) + (0.5 * (1 - 1/scale_factor));
        dy(dy < 1) = 1;
        dy(dy >= orig_height) = orig_height;
        
        y1 = floor(dy) - 1;
        y1(y1 < 1) = 1;
        y1(y1 >= orig_height) = orig_height;
        
        y2 = floor(dy);
        y2(y2 < 1) = 1;
        y2(y2 >= orig_height) = orig_height;
        
        y3 = floor(dy) + 1;
        y3(y3 < 1) = 1;
        y3(y3 >= orig_height) = orig_height;
        
        y4 = floor(dy) + 2;
        y4(y4 < 1) = 1;
        y4(y4 >= orig_height) = orig_height;
        
        for x_out = 1:new_width
            dx = (x_out/scale_factor) + (0.5 * (1 - 1/scale_factor));
            dx(dx < 1) = 1;
            dx(dx >= orig_width) = orig_width;
            
            x1 = floor(dx) - 1;
            x1(x1 < 1) = 1;
            x1(x1 >= orig_width) = orig_width;
            
            x2 = floor(dx);
            x2(x2 < 1) = 1;
            x2(x2 >= orig_width) = orig_width;
            
            x3 = floor(dx) + 1;
            x3(x3 < 1) = 1;
            x3(x3 >= orig_width) = orig_width;
            
            x4 = floor(dx) + 2;
            x4(x4 < 1) = 1;
            x4(x4 >= orig_width) = orig_width;
            
            cub_x1 = cubic(dx - x1);
            cub_x2 = cubic(dx - x2);
            cub_x3 = cubic(dx - x3);
            cub_x4 = cubic(dx - x4);
            cub_X = cub_x1 + cub_x2 + cub_x3 + cub_x4;
            
            cub_y1 = cubic(dy - y1);
            cub_y2 = cubic(dy - y2);
            cub_y3 = cubic(dy - y3);
            cub_y4 = cubic(dy - y4);
            cub_Y = cub_y1 + cub_y2 + cub_y3 + cub_y4;
            
%             fprintf('out_y: %d | out_x: %d | delta_x: %d | delta_y: %d\n', y_out, x_out, dx, dy);
%             fprintf('x1: %d | cub_x1: %0.4f \nx2: %d | cub_x2: %0.4f \nx3: %d | cub_x3: %0.4f \nx4: %d | cub_x4: %0.4f \n',x1, cub_x1, x2, cub_x2, x3, cub_x3, x4, cub_x4);
%             fprintf('y1: %d | cub_y1: %0.4f \ny2: %d | cub_y2: %0.4f \ny3: %d | cub_y3: %0.4f \ny4: %d | cub_y4: %0.4f \n',y1, cub_y1, y2, cub_y2, y3, cub_y3, y4, cub_y4);
            
            A1 = cub_x1*A(y1,x1)/cub_X + cub_x2*A(y1,x2)/cub_X + cub_x3*A(y1,x3)/cub_X + cub_x4*A(y1,x4)/cub_X;
            A2 = cub_x1*A(y2,x1)/cub_X + cub_x2*A(y2,x2)/cub_X + cub_x3*A(y2,x3)/cub_X + cub_x4*A(y2,x4)/cub_X;
            A3 = cub_x1*A(y3,x1)/cub_X + cub_x2*A(y3,x2)/cub_X + cub_x3*A(y3,x3)/cub_X + cub_x4*A(y3,x4)/cub_X;
            A4 = cub_x1*A(y4,x1)/cub_X + cub_x2*A(y4,x2)/cub_X + cub_x3*A(y4,x3)/cub_X + cub_x4*A(y4,x4)/cub_X;
            A_new(y_out,x_out) = cub_y1*A1/cub_Y + cub_y2*A2/cub_Y + cub_y3*A3/cub_Y + cub_y4*A4/cub_Y;
            
            B1 = cub_x1*B(y1,x1)/cub_X + cub_x2*B(y1,x2)/cub_X + cub_x3*B(y1,x3)/cub_X + cub_x4*B(y1,x4)/cub_X;
            B2 = cub_x1*B(y2,x1)/cub_X + cub_x2*B(y2,x2)/cub_X + cub_x3*B(y2,x3)/cub_X + cub_x4*B(y2,x4)/cub_X;
            B3 = cub_x1*B(y3,x1)/cub_X + cub_x2*B(y3,x2)/cub_X + cub_x3*B(y3,x3)/cub_X + cub_x4*B(y3,x4)/cub_X;
            B4 = cub_x1*B(y4,x1)/cub_X + cub_x2*B(y4,x2)/cub_X + cub_x3*B(y4,x3)/cub_X + cub_x4*B(y4,x4)/cub_X;
            B_new(y_out,x_out) = cub_y1*B1/cub_Y + cub_y2*B2/cub_Y + cub_y3*B3/cub_Y + cub_y4*B4/cub_Y;
            
            C1 = cub_x1*C(y1,x1)/cub_X + cub_x2*C(y1,x2)/cub_X + cub_x3*C(y1,x3)/cub_X + cub_x4*C(y1,x4)/cub_X;
            C2 = cub_x1*C(y2,x1)/cub_X + cub_x2*C(y2,x2)/cub_X + cub_x3*C(y2,x3)/cub_X + cub_x4*C(y2,x4)/cub_X;
            C3 = cub_x1*C(y3,x1)/cub_X + cub_x2*C(y3,x2)/cub_X + cub_x3*C(y3,x3)/cub_X + cub_x4*C(y3,x4)/cub_X;
            C4 = cub_x1*C(y4,x1)/cub_X + cub_x2*C(y4,x2)/cub_X + cub_x3*C(y4,x3)/cub_X + cub_x4*C(y4,x4)/cub_X;
            C_new(y_out,x_out) = cub_y1*C1/cub_Y + cub_y2*C2/cub_Y + cub_y3*C3/cub_Y + cub_y4*C4/cub_Y;
        end
    end

    % Combine colours into RGB image
    output_image = cat(3, A_new, B_new, C_new);
end