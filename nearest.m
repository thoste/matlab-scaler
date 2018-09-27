%% Neares neighbor interpolation

function output_image = nearest(input_image, scale_factor)
    % Separate each colour value from input image
    A = input_image(:,:,1);
    B = input_image(:,:,2);
    C = input_image(:,:,3);

    % Calculate size of input image
    [m,n] = size(A);
    
    % Allocate output image with new size
    m = ceil(m * scale_factor);
    n = ceil(n * scale_factor);
    A_new = uint8(zeros(m,n));
    B_new = uint8(zeros(m,n));
    C_new = uint8(zeros(m,n));

    % Run thourch each pixel in output image
    for i=1:m
        for j=1:n
            % Calculate corresponding position in input image
            % Need ceil/floor depending on scale_factor to be within
            % dimensions
            if scale_factor > 1
                x = ceil(i/scale_factor);
                y = ceil(j/scale_factor);
            else
                x = floor(i/scale_factor);
                y = floor(j/scale_factor);
            end
                
            % Assign value to output image
            A_new(i,j) = A(x,y);
            B_new(i,j) = B(x,y);
            C_new(i,j) = C(x,y);
        end
    end

    % Combine colours into RGB image
    output_image = cat(3, A_new, B_new, C_new);
end