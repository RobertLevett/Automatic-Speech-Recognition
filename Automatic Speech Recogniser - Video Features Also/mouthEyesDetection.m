function [BB] = mouthEyesDetection(inputFile)

%Read the input image 
I = imread(inputFile);
%To detect Mouth
MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',16);
BB=step(MouthDetect,I);
figure,
imshow(I); hold on
for i = 1:size(BB,1)
    rectangle('Position',BB(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','g');
end
%To detect Eyes
EyeDetect = vision.CascadeObjectDetector('EyePairBig');
BB=step(EyeDetect,I);
clehold on
rectangle('Position',BB,'LineWidth',4,'LineStyle','-','EdgeColor','b');
end