# matlab-scaler
MATLAB implementation of video and image scaling algorithms


## Functions
### nearest.m
Nearest neighbor interpolation algorithm. Supports both uint8 and uint16 input image. 

### bilinear.m
Bilinear interpolation algorithm.

### bicubic.m
Bicubic interpolation algorithm.

### rgb2ycbcr422.m
Convert RGB into YCbCr 4:2:2. 

### ycbcr2ycbcr422.m
Simulated subsampling of YCbCr 4:4:4 to YCbCr 4:2:2.

### getSingleFrame.m
Get single video frame from video at a given time in seconds. 

### qualityEstimation.m
Scales down an image, scales the image back up again, and do objective quality estimation on the results. 

