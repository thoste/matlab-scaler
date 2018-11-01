%% Bilinear interpolation

function output_image = bicubic2(input_image, scale_factor)
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
            if x >= orig_width
                x = orig_width;
                x1 = floor(x) - 2;
            else
                x1 = floor(x);
            end
            
            x2 = x1 + 1;
            x2(x2 < 1) = 1;
            if x2 >= orig_width
                x2 = orig_width;
            end
            
            x3 = x2 + 1;
            x3(x3 < 1) = 1;
            if x3 >= orig_width
                x3 = orig_width;
            end
            
            x4 = x3 + 1;
            x4(x4 < 1) = 1;
            if x4 >= orig_width
                x4 = orig_width;
            end
            
            y(y < 1) = 1;
            if y >= orig_height
                y = orig_height;
                y1 = floor(y) - 2;
            else
                y1 = floor(y);
            end
            
            y2 = y1 + 1;
            y2(y2 < 1) = 1;
            if y2 >= orig_height
                y2 = orig_height;
            end
            
            y3 = y2 + 1;
            y3(y3 < 1) = 1;
            if y3 >= orig_height
                y3 = orig_height;
            end
            
            y4 = y3 + 1;
            y4(y4 < 1) = 1;
            if y4 >= orig_height
                y4 = orig_height;
            end
            
            A_x1 = cubicFormula(a,(y3 - y))*A(y1,x1) + cubicFormula(a,(y4 - y))*A(y2,x1) + cubicFormula(a,(y - y1))*A(y3,x1) + cubicFormula(a, (y - y2))*A(y4,x1);
            A_x2 = cubicFormula(a,(y3 - y))*A(y1,x2) + cubicFormula(a,(y4 - y))*A(y2,x2) + cubicFormula(a,(y - y1))*A(y3,x2) + cubicFormula(a, (y - y2))*A(y4,x2);
            A_x3 = cubicFormula(a,(y3 - y))*A(y1,x3) + cubicFormula(a,(y4 - y))*A(y2,x3) + cubicFormula(a,(y - y1))*A(y3,x3) + cubicFormula(a, (y - y2))*A(y4,x3);
            A_x4 = cubicFormula(a,(y3 - y))*A(y1,x4) + cubicFormula(a,(y4 - y))*A(y2,x4) + cubicFormula(a,(y - y1))*A(y3,x4) + cubicFormula(a, (y - y2))*A(y4,x4);
            
            A_new(i,j) = cubicFormula(a,(x3 - x))*A_x1 + cubicFormula(a,(x4 - x))*A_x2 + cubicFormula(a,(x - x1))*A_x3 + cubicFormula(a,(x - x2))*A_x4;
            
            B_x1 = cubicFormula(a,(y3 - y))*B(y1,x1) + cubicFormula(a,(y4 - y))*B(y2,x1) + cubicFormula(a,(y - y1))*B(y3,x1) + cubicFormula(a, (y - y2))*B(y4,x1);
            B_x2 = cubicFormula(a,(y3 - y))*B(y1,x2) + cubicFormula(a,(y4 - y))*B(y2,x2) + cubicFormula(a,(y - y1))*B(y3,x2) + cubicFormula(a, (y - y2))*B(y4,x2);
            B_x3 = cubicFormula(a,(y3 - y))*B(y1,x3) + cubicFormula(a,(y4 - y))*B(y2,x3) + cubicFormula(a,(y - y1))*B(y3,x3) + cubicFormula(a, (y - y2))*B(y4,x3);
            B_x4 = cubicFormula(a,(y3 - y))*B(y1,x4) + cubicFormula(a,(y4 - y))*B(y2,x4) + cubicFormula(a,(y - y1))*B(y3,x4) + cubicFormula(a, (y - y2))*B(y4,x4);
            
            B_new(i,j) = cubicFormula(a,(x3 - x))*B_x1 + cubicFormula(a,(x4 - x))*B_x2 + cubicFormula(a,(x - x1))*B_x3 + cubicFormula(a,(x - x2))*B_x4;
            
            C_x1 = cubicFormula(a,(y3 - y))*C(y1,x1) + cubicFormula(a,(y4 - y))*C(y2,x1) + cubicFormula(a,(y - y1))*C(y3,x1) + cubicFormula(a, (y - y2))*C(y4,x1);
            C_x2 = cubicFormula(a,(y3 - y))*C(y1,x2) + cubicFormula(a,(y4 - y))*C(y2,x2) + cubicFormula(a,(y - y1))*C(y3,x2) + cubicFormula(a, (y - y2))*C(y4,x2);
            C_x3 = cubicFormula(a,(y3 - y))*C(y1,x3) + cubicFormula(a,(y4 - y))*C(y2,x3) + cubicFormula(a,(y - y1))*C(y3,x3) + cubicFormula(a, (y - y2))*C(y4,x3);
            C_x4 = cubicFormula(a,(y3 - y))*C(y1,x4) + cubicFormula(a,(y4 - y))*C(y2,x4) + cubicFormula(a,(y - y1))*C(y3,x4) + cubicFormula(a, (y - y2))*C(y4,x4);
            
            C_new(i,j) = cubicFormula(a,(x3 - x))*C_x1 + cubicFormula(a,(x4 - x))*C_x2 + cubicFormula(a,(x - x1))*C_x3 + cubicFormula(a,(x - x2))*C_x4;

        end
    end

    % Combine colours into RGB image
    output_image = cat(3, A_new, B_new, C_new);
end