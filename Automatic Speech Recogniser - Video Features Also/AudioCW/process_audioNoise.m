function [] = process_audioNoise(speechFile)

    speechData = audioread(speechFile);
    
    numSamples = length(speechData);
    frameLength = 320;
    numFrames = floor( numSamples / frameLength );
    
    for frame = 1:numFrames
        first = (frame-1)*frameLength+1;
        last = (first+frameLength-1);
        shortFrame = speechData(first:last);
        [magSpec, phaseSpec] = magAndPhase(shortFrame);
        
        
        subplot(2,2,1);
        plot(magSpec);
        xlim([0 320])
        subplot(2,2,2);
        plot(phaseSpec);
        xlim([0 320])
        
        if frame ~= numFrames
        
        overFirst = first+(frameLength/2);
        overLast = last+(frameLength/2);
        shortFrame2 = speechData(overFirst:overLast);
        [magSpecs, phaseSpecs] = magAndPhase(shortFrame2);

        
        subplot(2,2,3);
        plot(magSpecs);
        xlim([0 320])
        subplot(2,2,4);
        plot(phaseSpecs);
        xlim([0 320])
        end
%         pause(eps)
        drawnow
    end
   
end