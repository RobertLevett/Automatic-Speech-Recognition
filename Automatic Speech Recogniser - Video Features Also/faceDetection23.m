function [bboxes] = faceDetection(InputFile,OutputFile)
    faceDetector = vision.CascadeObjectDetector;
    img = imread(InputFile);
    bboxes = faceDetector(img);
    rectangle('Position',bboxes,'LineWidth',3,'LineStyle','-', 'EdgeColor','r');
    J = imcrop(img,bboxes);
    imshow(J);
    saveas(gcf,OutputFile)
end