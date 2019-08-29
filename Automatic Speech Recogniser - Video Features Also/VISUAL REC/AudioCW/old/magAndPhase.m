function [shortMag, shortPhase] = magAndPhase(shortFrame)
    h = hamming(length(shortFrame));
    xH = shortFrame .* h;
    xF = fft(xH);

    shortMag = abs(xF);
    shortPhase = angle(xF);
end