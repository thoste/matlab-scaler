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
        
        y1 = floor(dy) - 1;
        y1(y1 < 1) = 1;
        
        y2 = y1 + 1;
        y3 = y2 + 1;
        y4 = y3 + 1;

        % Keep kernel within boundaries
        if y4 >= orig_height 
            y4 = orig_height;
            y3 = y4 - 1;
            y2 = y3 - 1;
            y1 = y2 - 1;
        end
        
        for x_out = 1:new_width
            dx = (x_out/scale_factor) + (0.5 * (1 - 1/scale_factor));
            
            x1 = floor(dx) - 1;
            x1(x1 < 1) = 1;

            x2 = x1 + 1;
            x3 = x2 + 1;
            x4 = x3 + 1;

            % Keep kernel within boundaries
            if x4 >= orig_width 
                x4 = orig_width;
                x3 = x4 - 1;
                x2 = x3 - 1;
                x1 = x2 - 1;
            end
            
            % Calculate cubic interpolation
            cub_x1 = double(cubic(dx - x1));
            cub_x2 = double(cubic(dx - x2));
            cub_x3 = double(cubic(dx - x3));
            cub_x4 = double(cubic(dx - x4));
            cub_X = double(cub_x1 + cub_x2 + cub_x3 + cub_x4);
            
            cub_y1 = double(cubic(dy - y1));
            cub_y2 = double(cubic(dy - y2));
            cub_y3 = double(cubic(dy - y3));
            cub_y4 = double(cubic(dy - y4));
            cub_Y = double(cub_y1 + cub_y2 + cub_y3 + cub_y4);
            
            % Calculate pixel values
            A1 = cub_x1*double(A(y1,x1))/cub_X + cub_x2*double(A(y1,x2))/cub_X + cub_x3*double(A(y1,x3))/cub_X + cub_x4*double(A(y1,x4))/cub_X;
            A2 = cub_x1*double(A(y2,x1))/cub_X + cub_x2*double(A(y2,x2))/cub_X + cub_x3*double(A(y2,x3))/cub_X + cub_x4*double(A(y2,x4))/cub_X;
            A3 = cub_x1*double(A(y3,x1))/cub_X + cub_x2*double(A(y3,x2))/cub_X + cub_x3*double(A(y3,x3))/cub_X + cub_x4*double(A(y3,x4))/cub_X;
            A4 = cub_x1*double(A(y4,x1))/cub_X + cub_x2*double(A(y4,x2))/cub_X + cub_x3*double(A(y4,x3))/cub_X + cub_x4*double(A(y4,x4))/cub_X;
            A_new(y_out,x_out) = cub_y1*A1/cub_Y + cub_y2*A2/cub_Y + cub_y3*A3/cub_Y + cub_y4*A4/cub_Y;
            
            B1 = cub_x1*double(B(y1,x1))/cub_X + cub_x2*double(B(y1,x2))/cub_X + cub_x3*double(B(y1,x3))/cub_X + cub_x4*double(B(y1,x4))/cub_X;
            B2 = cub_x1*double(B(y2,x1))/cub_X + cub_x2*double(B(y2,x2))/cub_X + cub_x3*double(B(y2,x3))/cub_X + cub_x4*double(B(y2,x4))/cub_X;
            B3 = cub_x1*double(B(y3,x1))/cub_X + cub_x2*double(B(y3,x2))/cub_X + cub_x3*double(B(y3,x3))/cub_X + cub_x4*double(B(y3,x4))/cub_X;
            B4 = cub_x1*double(B(y4,x1))/cub_X + cub_x2*double(B(y4,x2))/cub_X + cub_x3*double(B(y4,x3))/cub_X + cub_x4*double(B(y4,x4))/cub_X;
            B_new(y_out,x_out) = cub_y1*B1/cub_Y + cub_y2*B2/cub_Y + cub_y3*B3/cub_Y + cub_y4*B4/cub_Y;
            
            C1 = cub_x1*double(C(y1,x1))/cub_X + cub_x2*double(C(y1,x2))/cub_X + cub_x3*double(C(y1,x3))/cub_X + cub_x4*double(C(y1,x4))/cub_X;
            C2 = cub_x1*double(C(y2,x1))/cub_X + cub_x2*double(C(y2,x2))/cub_X + cub_x3*double(C(y2,x3))/cub_X + cub_x4*double(C(y2,x4))/cub_X;
            C3 = cub_x1*double(C(y3,x1))/cub_X + cub_x2*double(C(y3,x2))/cub_X + cub_x3*double(C(y3,x3))/cub_X + cub_x4*double(C(y3,x4))/cub_X;
            C4 = cub_x1*double(C(y4,x1))/cub_X + cub_x2*double(C(y4,x2))/cub_X + cub_x3*double(C(y4,x3))/cub_X + cub_x4*double(C(y4,x4))/cub_X;
            C_new(y_out,x_out) = cub_y1*C1/cub_Y + cub_y2*C2/cub_Y + cub_y3*C3/cub_Y + cub_y4*C4/cub_Y;
        end
    end

    % Combine colours into RGB image
    output_image = cat(3, A_new, B_new, C_new);
end