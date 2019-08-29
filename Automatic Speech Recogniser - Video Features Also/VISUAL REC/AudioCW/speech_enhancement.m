function [mag_estimate] = speech_enhancement(magSpec, noise_estimate, xF)
%     m = mean(shortTimeMag)     
%     x  = shortTimeMag - m;
 
   
    realPart = real(xF);
    fakePart = imag(xF);
    realSquare = realPart.^2;
    fakeSquare = fakePart.^2;
    addTogether = realSquare + fakeSquare;

    rootTogether = sqrt(addTogether);

    
    rootTogether = rootTogether';
    
    for i = 1:length(rootTogether)
        if(rootTogether(i) - noise_estimate(i)) < 0
            magEst(i) = 0;
        else
            magEst(i) = rootTogether(i) - noise_estimate(i);
        end
    end
    
    magSpec = magSpec';
    
%     for i = 1:length(magSpec)
%         
%     end
%     
    mag_estimate = magEst;
    
    
    
%     subplot(2,2,1);
%     plot(magSpec);
%     subplot(2,2,3);
%     plot(mag_estimate);
end