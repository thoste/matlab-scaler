clear variables;
addpath('functions');

videoObj = VideoReader('video/sony1080p.mp4');

vidWidth = videoObj.Width;
vidHeight = videoObj.Height;

mov = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'), 'colormap',[]);

k = 1;
while hasFrame(videoObj)
    mov(k).cdata = readFrame(videoObj);
    k = k+1;
end

% hf = figure;
% set(hf,'position',[1 1 vidWidth vidHeight]);
% movie(hf,mov,1,videoObj.FrameRate);

implay(mov);