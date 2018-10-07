# matlab-scaler
MATLAB implementation of video and image scaling algorithms


## Functions
### bilinear.m
Bilinear interpolation algorithm.

### getSingleFrame.m
Get single video frame from video at a given time in seconds. 

### nearest.m
Nearest neighbor interpolation algorithm. Supports both uint8 and uint16 input image. 

### qualityEstimation.m
Scales down an image, scales the image back up again, and do objective quality estimation on the results. 

### rgb2ycbcr422.m
Convert RGB into YCbCr 4:2:2. Only uint8 support at the time. 


## Scripts
### matlab_example_scaler.m
Compare Matlab's own implementation of nearest neighbor, biliner and bicubic interpolation with each other. 

### nearest_neighbor_interpolation.m
Does nearest neighbor interpolation on one picture, calculates quality metrics, and produces and displays SSIM map. 

### quality_estimation.m
Runs through all images specified and produces quality metrics for each image for one specified scaling algorithm. The result is stores in results.txt.

### video_reader.m
Example on how to loop through each frame of a video file. 

### YCbCr_444_vs_422.m
Compares YCbCr 4:4:4 with 4:2:2 chroma subsampling. 

### YCbCr_separate.m
Example on how to separate each subsomponent of a YCbCr image. 