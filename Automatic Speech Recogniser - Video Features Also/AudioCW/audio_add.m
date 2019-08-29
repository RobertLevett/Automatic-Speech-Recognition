function [] = audio_add(noiseFile)
    noiseSound = audioread(noiseFile);
    for k = 1:9
        k
        speechFileIn = strcat('speech00', num2str(k), '.wav');
        speechFileOut = strcat('speech00', num2str(k), 'Gun.wav');

        s2 = audioread(speechFileIn); 
        
        len = max(size(s2,1));
        
        sNoise = noiseSound(1:len,:) + s2(1:len,:);
        normalized = sNoise / max(abs(sNoise));
        audiowrite(speechFileOut,normalized,16000);
    end
end