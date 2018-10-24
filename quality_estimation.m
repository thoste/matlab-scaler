clear variables;
addpath('functions');

natural = ["img/natural/TwoMacaws.tif", "img/natural/PortlandHeadLight.tif", "img/natural/PlanetEarth2a.png", "img/natural/PlanetEarth2b.png", "img/natural/PlanetEarth2c.png"];
animation = ["img/animation/LionKing.png", "img/animation/ToyStory.png"];
games = ["img/games/Battlefield1.png", "img/games/Fortnite.png"];

% Put all image paths in one array
images = [natural, animation, games];

% Algorithm to run
algorithm = 'matlab';
method = 'bilinear';
scale_factor = 0.25;
matlab_AA_filter = true;

% Open file for writing results
if scale_factor < 1
    file_name = strcat('results/results_',algorithm,'_',method,'_downscale.csv');
else
    file_name = strcat('results/results_',algorithm,'_',method,'_upscale.csv');
end
fprintf('File for storing results: %s\n', file_name);
fileID = fopen(file_name,'w');


% Write first line CSV format
fprintf(fileID,'image,psnrrgb,psnrycbcr,snrrgb,snrycbcr,msergb,mseycbcr,ssimrgb,ssimycbcr\n');

for i = 1:size(images,2)
    % Info print
    fprintf('Processing file: %s\n', images(i));
    
    % Calculate quality estimate
    quality = qualityEstimation(images(i), algorithm, method, scale_factor, matlab_AA_filter);
    
    % Format image name
    old = {'img/natural/','img/animation/','img/games/', '.tif', '.png'};
    new = '';
    image_name = replace(images(i), old, new);
    
    %Write result to file CSV format
    fprintf(fileID,image_name);
    formatSpec = ',%#.4g';
    [nrows,ncols] = size(quality);
    for row = 1:nrows
        fprintf(fileID,formatSpec,quality{row,2});
    end
    fprintf(fileID,'\n');
end

% Close file
fclose(fileID);
fprintf('Done\n');
