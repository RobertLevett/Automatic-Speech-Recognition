fs = 16000;

rec = audiorecorder(fs,16,1);

disp('Start speaking.')
recordblocking(rec, 3);
disp('End of Recording.');

audioData = getaudiodata(rec);

y = audioData(1:320).*hamming(320);
y = reshape(x,[320 150]);
y = y.*repmat(hamming(320),1,150);
plot(y);
