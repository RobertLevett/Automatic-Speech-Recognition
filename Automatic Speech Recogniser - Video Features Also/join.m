function [] = join(soundFile,videoFile)
audioFeatures = audio_process(soundFile,10);
videoFeatures = readVid(videoFile);
videoFeatures = videoFeatures';
[m,n] = size(videoFeatures); %no of columns

size(audioFeatures)
size(videoFeatures)

audioFeatures = audioFeatures(1:m,1:33);

allFeatures = [audioFeatures videoFeatures];
writeMFCC(allFeatures,'file1S.mfc');
end

