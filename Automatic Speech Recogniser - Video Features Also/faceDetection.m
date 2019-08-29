function [J] = faceDetection(InputFile, faceDetector)
%     img = imread(InputFile);
    bboxes = step(faceDetector, InputFile);
%     for i=1: size(bboxes,1)
%         rectangle('Position',bboxes(i,:),'LineWidth',3,'LineStyle','-', 'EdgeColor','r');
%     end
    for i =1 : size(bboxes,1)
        J = imcrop(InputFile,bboxes(i,:));
    end
%      imshow(J);
%      pause(eps);
%     imwrite(J,OutputFile);
%     saveas(J,OutputFile)
end