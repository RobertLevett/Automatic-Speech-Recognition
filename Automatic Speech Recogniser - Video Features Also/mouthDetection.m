function [BB] = mouthDetection(InputFile)
    %Read the input image 
    I = imread(InputFile);
    %To detect Mouth
    MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',170);
    BB=step(MouthDetect,I);
%     figure,
%     imshow(I); hold on
% for i = 1:size(BB,1)
%     rectangle('Position',BB(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','g');
% end
    J = imcrop(I,BB);
%     figure,
%     imshow(J);
end
