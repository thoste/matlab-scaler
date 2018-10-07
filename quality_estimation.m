clear variables;
addpath('functions');

natural = ["img/natural/IMG0023.tif", "img/natural/IMG0021.tif", "img/natural/planetearth2.png", "img/natural/planetearth2_2.png", "img/natural/planetearth2_3.png"];
animation = ["img/animation/LionKing.png"];
games = ["img/games/bf1.png", "img/games/fortnite.png"];

% Put all image paths in one array
images = [natural, animation, games];

% Algorithm to run
algorithm = 'nearest';

% Open file for writing results
file_name = strcat('results_',algorithm,'.txt');
fileID = fopen(file_name,'w');

for i = 1:size(images,2)
    % Info print
    fprintf('Processing file: %s\n', images(i));
    
    % Calculate quality estimate
    quality = qualityEstimation(images(i), algorithm);
    
    %Write result to file
    fprintf(fileID,'File: %s\n', images(i));
    formatSpec = '%s %0.4f\n';
    [nrows,ncols] = size(quality);
    for row = 1:nrows
        fprintf(fileID,formatSpec,quality{row,:});
    end
    fprintf(fileID,'\n\n');
end

% Close file
fclose(fileID);

