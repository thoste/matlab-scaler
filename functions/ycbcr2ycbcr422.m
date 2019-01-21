%% Convert from YCbCr 4:4:4 to YCbCr 4:2:2

function YCbCr422 = ycbcr2ycbcr422(YCbCr444)
    % Separate each colour value from input image
    Y = YCbCr444(:,:,1);
    Cb = YCbCr444(:,:,2);
    Cr = YCbCr444(:,:,3);

    % Simulate 4:2:2 chroma sampling
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
    
    YCbCr422 = cat(3,Y,Cb_422,Cr_422);
end