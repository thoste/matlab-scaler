%% Convert RGB into YCbCr 4:2:2

function YCbCr = rgb2ycbcr422(RGB)
    % Separate each colour value from input image
    R = RGB(:,:,1);
    G = RGB(:,:,2);
    B = RGB(:,:,3);

    % RGB to YCbCr 
    Y = 16 + (65.738/256)*R + (129.057/256)*G + (25.064/256)*B;
    Cb = 128 - (37.945/256)*R - (74.494/256)*G + (112.439/256)*B;
    Cr = 128 + (112.439/256)*R - (94.154/256)*G - (18.285/256)*B;

    % 4:2:2 chroma sampling
    [m,n] = size(Y);
    Cb_422 = zeros(m,n);
    Cr_422 = zeros(m,n);
    for i=1:n
        if(mod(i,2) ~= 0)
            Cb_422(:,i) = Cb(:,i);
            Cr_422(:,i) = Cr(:,i);
        else
            Cb_422(:,i) = Cb(:,i-1);
            Cr_422(:,i) = Cr(:,i-1);
        end
    end
    
    YCbCr = cat(3,Y,Cb_422,Cr_422);
end