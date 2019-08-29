recObj = audiorecorder;
for fileNumber = 1:10
disp('Start speaking.');
recordblocking(recObj, 5);
disp('End of Recording.');
myRecording = getaudiodata(recObj);
xNorm = myRecording / max(abs(myRecording));
filename = strcat('speech',int2str(fileNumber),'.wav');
audiowrite(filename, xNorm, 16000);
end