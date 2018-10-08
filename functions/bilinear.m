%% Bilinear interpolation

function output_image = bilinear(input_image, scale_factor)
    % Separate each colour value from input image
    A = input_image(:,:,1);
    B = input_image(:,:,2);
    C = input_image(:,:,3);

    % Calculate size of input image
    [k,l] = size(A);

    % Allocate output image with new size
    m = ceil(k * scale_factor);
    n = ceil(l * scale_factor);
    bit = class(input_image);
    A_new = zeros(m,n,bit);
    B_new = zeros(m,n,bit);
    C_new = zeros(m,n,bit);
    
    sy = (k/m);
    sx = (l/n);

    dx = 1;
    dy = 1;
    
    % Run thourch each pixel in output image
    for i = 1:m
        dy = dy + sy;
        y1 = floor(dy);
        y2 = y1 + 1;
        if y2 > k
            y1 = k-1;
            y2 = k;
        end
        if dy > y2
            dy = y2;
        end

        for j = 1:n
            dx = dx + sx;
            x1 = floor(dx);
            x2 = x1 + 1;
            if x2 > l
                x1 = l-1;
                x2 = l;
            end
            if dx > x2
                dx = x2;
            end
  
            
            Ax_y1 = (x2 - dx)*A(y1,x1) + (dx - x1)*A(y1,x2);
            Ax_y2 = (x2 - dx)*A(y2,x1) + (dx - x1)*A(y2,x2);
            A_new(i,j) = (y2 - dy)*Ax_y1 + (dy - y1)*Ax_y2;
            
            Bx_y1 = (x2 - dx)*B(y1,x1) + (dx - x1)*B(y1,x2);
            Bx_y2 = (x2 - dx)*B(y2,x1) + (dx - x1)*B(y2,x2);
            B_new(i,j) = (y2 - dy)*Bx_y1 + (dy - y1)*Bx_y2;
            
            Cx_y1 = (x2 - dx)*C(y1,x1) + (dx - x1)*C(y1,x2);
            Cx_y2 = (x2 - dx)*C(y2,x1) + (dx - x1)*C(y2,x2);
            C_new(i,j) = (y2 - dy)*Cx_y1 + (dy - y1)*Cx_y2;
            
        end
        dx = 1;
    end

    % Combine colours into RGB image
    output_image = cat(3, A_new, B_new, C_new);
end