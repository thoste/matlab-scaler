function output_image = interpolate(input_image, scale_factor, method)
    switch method
        case 'nearest'
            output_image = nearest(input_image, scale_factor);
        case 'bilinear'
            output_image = bilinear(input_image, scale_factor);
        case 'bicubic'
            output_image = bicubic(input_image, scale_factor);
        otherwise
            % Set default to nearest
            output_image = nearest(input_image, scale_factor);
    end
end