%% Play a Video From a File and pause wherever necessary.
clc
clear all
close all
%% Specifications of the Video
readerobj = VideoReader('race.mp4');
videoFReader   = vision.VideoFileReader('race.mp4');
depVideoPlayer = vision.DeployableVideoPlayer;
%% Video

prompt_time = 'Enter the time in seconds : ';
time_input = input(prompt_time);

prompt_freeze = 'Enter the duration of freeze : ';
freeze_input = input(prompt_freeze);

FrameRate = 30;

check = time_input * FrameRate;
% Continue to read frames of video until the last frame is read. Exit the loop if user closes the video player window.
cont = ~isDone(videoFReader);
c = 0;
  while cont
    frame = step(videoFReader);
    step(depVideoPlayer, frame);   
    if c == check
        pause(freeze_input);
        disp('Run');
    end
    cont = ~isDone(videoFReader) && isOpen(depVideoPlayer);
    c = c + 1;
  end
%% Release System objects.

release(videoFReader);
release(depVideoPlayer);
