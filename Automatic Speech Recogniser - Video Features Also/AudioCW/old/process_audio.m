function [] = process_audio(speechFile)

    speechData = audioread(speechFile);
    
    numSamples = length(speechData);
    frameLength = 320;
    numFrames = floor( numSamples / frameLength );
    
    for frame = 1:numFrames
        first = (frame-1)*frameLength+1;
        last = (first+frameLength-1);
        shortFrame = speechData(first:last);
        [magSpec, phaseSpec] = magAndPhase(shortFrame);
        
        
        subplot(2,3,1);
        plot(magSpec);
        xlim([0 320])
        subplot(2,3,2);
        plot(phaseSpec);
        xlim([0 320])
     %   subplot(2,3,3);
    %    spectrogram(shortFrame, 64, 40, 512, 16000,'yaxis');
   %     xlim([1 18])
        
        if frame ~= numFrames
        
        overFirst = first+(frameLength/2);
        overLast = last+(frameLength/2);
        shortFrame2 = speechData(overFirst:overLast);
        [magSpecs, phaseSpecs] = magAndPhase(shortFrame2);

        
        subplot(2,3,4);
        plot(magSpecs);
        xlim([0 320])
        subplot(2,3,5);
        plot(phaseSpecs);
        xlim([0 320])
   %     subplot(2,3,6);
  %      spectrogram(shortFrame2, 64, 40, 512, 16000,'yaxis');
 %       xlim([1 18])
        end
       pause(eps)
%        drawnow
    end
   
end