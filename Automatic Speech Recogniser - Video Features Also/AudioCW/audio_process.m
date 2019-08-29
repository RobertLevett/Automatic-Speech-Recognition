function [] = audio_process(speechFile, numChan)
% for k = 1:9
%     k
%     speechFile = strcat('speech01', num2str(k), '.wav');
%     mfccName = strcat('speech01', num2str(k), '.mfc');

    speechData = audioread(speechFile);
    numSamples = length(speechData);
    frameLength = 320;
    numFrames = floor(numSamples/(frameLength/2)-1);
    
    
%       3*number of filterbank channels
    mat_vec = zeros(numFrames, numChan*3 + 3);

    for frame = 1:numFrames

        %1, 320
        first = (frame -1)*(frameLength/2)+1;
        last = first+frameLength -1;

        
        shortTimeFrame = speechData(first:last);
        shortTimeFrame = shortTimeFrame';
%       populate vector with energy of features
        energy = sum(shortTimeFrame(1:(frameLength/2)).^2);
        [shortTimeMag,shortTimePhase] = audio_passed(shortTimeFrame);


%         
%       if (last+(frameLength/2))+(last+(160))>numSamples
%       end
%         

%       only half of the magnitude
        halfMag = shortTimeMag(1:(length(shortTimeMag)/2));
%       use mel Triangular  filterbank
        mfccCos = melFiltSquare(halfMag,numChan);
        
%       truncation GOES HERE
        

        mat_vec(frame, ((numChan*3)+1):((numChan*3)+1)) =  energy;
%       populate vector with features
        mat_vec(frame, 1:numChan) = mfccCos;

        
    end

    %calculate velocity and populate the vector
    for vec = 1:numFrames
       if vec == 1 
           mat_vec(vec, (numChan+1):(numChan*2)) = mat_vec(vec+1, 1:numChan) - mat_vec(vec, 1:numChan);
       elseif vec == numFrames  
           mat_vec(vec, (numChan+1):(numChan*2)) = mat_vec(vec, 1:numChan) - mat_vec(vec-1, 1:numChan);
       else
           mat_vec(vec, (numChan+1):(numChan*2)) = mat_vec(vec+1, 1:numChan) - mat_vec(vec-1, 1:numChan);
       end
       %populate vector with velocity energy
        mat_vec(vec, ((numChan*3)+2):((numChan*3)+2)) =  sum(mat_vec(vec,(numChan+1):(numChan*2)).^2);
    end

    %calculate acceleration and populate the vector
    for vec = 1:numFrames
       if vec == 1 
           mat_vec(vec, ((numChan*2)+1):(numChan*3)) = mat_vec(vec+1, (numChan+1):(numChan*2)) - mat_vec(vec, (numChan+1):(numChan*2));
       elseif vec == numFrames
           mat_vec(vec, ((numChan*2)+1):(numChan*3)) = mat_vec(vec, (numChan+1):(numChan*2)) - mat_vec(vec-1, (numChan+1):(numChan*2));
       else
           mat_vec(vec, ((numChan*2)+1):(numChan*3)) = mat_vec(vec+1, (numChan+1):(numChan*2)) - mat_vec(vec-1, (numChan+1):(numChan*2));
       end
       %populate vector with accleration energy
        mat_vec(vec, ((numChan*3)+3):((numChan*3)+3)) = sum(mat_vec(vec,((numChan*2)+1):((numChan*3))).^2);   
    end
    
    %write to the file
    writeMFCC(mat_vec,'file010.mfc')
% end
end
     