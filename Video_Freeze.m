% clc; 
% clear all; 
% close all;

%%

[filename, path] = uigetfile('.avi','select video');
vid = VideoReader(strcat(path, filename));

%%

Video = VideoWriter('OUT.mp4');

%%

prompt_time = 'Enter the time in seconds where you want the video to freeze: ';
freeze_time = input(prompt_time);

prompt_freeze = 'Enter the duration for which the video has to remain frozen : ';
frozen_time = input(prompt_freeze);

Freeze_framePosition = round(freeze_time * vid.FrameRate);

Frozen_frameCount = round(frozen_time * vid.FrameRate);

for i = 1 : Freeze_framePosition
    frame{i}= read(vid,i);
end

for i = Freeze_framePosition + 1 : Freeze_framePosition + Frozen_frameCount
    frame{i} = read(vid,Freeze_framePosition);
end

for i = Freeze_framePosition + 1 : vid.NumberOfFrames
    frame{i+Frozen_frameCount} = read(vid,i);
end

%%

open(Video);

for i = 1 : vid.NumberOfFrames + Frozen_frameCount
    writeVideo(Video,frame{i});
end

close(Video);
