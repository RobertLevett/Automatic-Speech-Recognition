function [magSpec,shortTimePhase,test] = audio_passed2(speechFrame)
    l = length(speechFrame);


    h = hamming(l);
    xH = speechFrame.*h;
    xF = fft(xH);
    
    test = xF;
    
    magSpec = abs(xF);
  
    shortTimePhase = angle(xF);
    
end

