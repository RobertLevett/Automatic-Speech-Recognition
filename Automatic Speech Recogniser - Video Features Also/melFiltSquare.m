function [mfccCos] = melFiltSquare(mag,channelLength)

firstBin = 0;
lastBin = 0;

len = length(mag);

K=channelLength;

for channel = 1:K
    
    firstBin = lastBin + 1;
    
    
    lastBin =  lastBin + (len/K); %160/10
    floor(firstBin);
    floor(lastBin);
     
    filterbank(channel) = mean(mag(firstBin:lastBin));

    %filterbank can be used for report on square channel, 
    %for now, not returned.
end
logsMfcc = log10(filterbank);

mfccCos = dct(logsMfcc);

%plot(mfcc2);
end

