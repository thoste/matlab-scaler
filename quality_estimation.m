clear variables;
addpath('functions');

natural = ["img/natural/TwoMacaws.tif", "img/natural/PortlandHeadLight.tif", "img/natural/planetearth2a.png", "img/natural/planetearth2b.png", "img/natural/planetearth2c.png"];
animation = ["img/animation/LionKing.png", "img/animation/ToyStory.png"];
games = ["img/games/bf1.png", "img/games/fortnite.png"];

% Put all image paths in one array
images = [natural, animation, games];

% Algorithm to run
algorithm = 'bilinear';

% Open file for writing results
file_name = strcat('results_',algorithm,'.csv');
fileID = fopen(file_name,'w');

% Write first line CSV format
fprintf(fileID,'image,psnrrgb,psnrycbcr,snrrgb,snrycbcr,msergb,mseycbcr,ssimrgb,ssimycbcr\n');


for i = 1:size(images,2)
    % Info print
    fprintf('Processing file: %s\n', images(i));
    
    % Calculate quality estimate
    quality = qualityEstimation(images(i), algorithm);
    
    %Write result to file CSV format
    fprintf(fileID,images(i));
    formatSpec = ',%0.4f';
    [nrows,ncols] = size(quality);
    for row = 1:nrows
        fprintf(fileID,formatSpec,quality{row,2});
    end
    fprintf(fileID,'\n');
end

% Close file
fclose(fileID);

