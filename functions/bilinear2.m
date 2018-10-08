%% Bilinear interpolation

function output_image = bilinear2(input_image, scale_factor)
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
    
    % Run thourch each pixel in output image
    for i = 1:m
        for j = 1:n

            
        end
    end

    % Combine colours into RGB image
    output_image = cat(3, A_new, B_new, C_new);
end