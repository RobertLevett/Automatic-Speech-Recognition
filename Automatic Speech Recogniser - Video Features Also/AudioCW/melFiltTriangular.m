function [mfccCos] = melFiltTriangular(mag,channelLength)


%get lower and upper Mel Freq
lowerMelF = 1125*log(1+300/700);
upperMelF = 1125*log(1+8000/700);

%difference between points
differ = (upperMelF-lowerMelF)/(channelLength+1);


next = lowerMelF;
for n=1:(channelLength+2)
    %mel frequency vector populatet
    melFreqVec(n)=next;
    next = next + differ;
%     hzFreqVec(n) = 1125*log(1+melFreqVec(n)/700)
    %convert Mel freq to Hz
    hzFreqVec(n) = 700*(exp(melFreqVec(n)/1125)-1);
    %convert Hz to points for spacing
    points(n) = floor((320+1)*hzFreqVec(n)/16000);
end

%populate with zeros
filter_mat = zeros(channelLength, 160);

for n=2:(channelLength+1)
    
    %find first,mid and last point
    first = points(n-1);
    mid   = points(n);
    last  = points(n+1);
    
    
    %find the slope from the first to the mid point
    for j = first : mid
        filter_mat(n-1,j) = (j-points(n-1))/(points(n)-points(n-1));

%         if i < left 
%         left=0;
%         elseif left <= i <= mid
%         (i-mag(mid-1))/(mag(mid)-mag(mid-1))
    end
    
    %finds slope from the mid to the last point
    for k = mid : last
       filter_mat(n-1,k) = (points(n+1)-k)/(points(n+1)-points(n));
    end
    
end

%invert the vector

% for i =1:channelLength
%    plot(filter_mat(i, :))
% end    
% 
% test = zeros(1,channelLength);
% 
% for n = 1:channelLength
%     test(n)
%     test(n)= mag*filter_mat(n);
% end


%multiply magnitude with extracted slopes 
featureVector = mag * filter_mat';



mfccCos = featureVector;



end


