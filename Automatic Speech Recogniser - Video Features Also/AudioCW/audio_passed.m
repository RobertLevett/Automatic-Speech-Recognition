function [shortTimeMag,shortTimePhase] = audio_passed(speechFrame)


    l = length(speechFrame);
    h = hamming(l);             %tranform into frequency
    
    xH = speechFrame.*h;        %multiply every file in a speech file by the hamming window
    xF = fft(xH);               %fast fourier tranform of xH
    
    shortTimeMag = abs(xF);     %extract Magnitude
    shortTimePhase = angle(xF); %extract Phase
end