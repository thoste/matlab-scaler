%% Get single video frame from video at a given time in seconds

function videoFrame = getSingleFrame(video, seconds)
    reader = VideoReader(video);
    reader.CurrentTime = seconds;
    videoFrame = readFrame(reader);
end