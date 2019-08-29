function [upsampledFeatures] = readVid(InputFile)
    v = VideoReader(InputFile);
    counter=1;
    while hasFrame(v)
        
        d = readFrame(v);
%         p = d;
%         imwrite(p,'temp.jpg');
%         f = faceDetection(d,faceDetector);
%         P =  imtool('tempFace.jpg')
%         face = imread('tempFace.jpg');
        
        %change 2nd number 380-425 if you want to create new MFCCs
        newFace = imcrop(d,[560 380 198 176]);
%         imwrite(newFace,'newFace.jpg');
%        imshow(newFace);
%         pause(eps);

        
            
        all(counter,:) = logicalImg(newFace);
        counter = counter+1;
        
%         imshow(newFace);
%         mouthDetection('tempFace.jpg');
    end
    upsampledFeatures = upSample(all);

%     writeMFCC(all,'file010.mfc',counter);
end


