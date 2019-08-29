function [] = audio_process_n(speechFile, numChan)
% for k = 5:9
%     speechFile = strcat('speech01', num2str(k), '.wav');
%     mfccName = strcat('speech01', num2str(k), '.mfc');

    speechData = audioread(speechFile);
    numSamples = length(speechData);
    frameLength = 320;
    numFrames = floor(numSamples/(frameLength/2)-1);
    
    
%       3*number of filterbank channels
    mat_vec = zeros(numFrames, numChan*3 + 3);

    for frame = 1:19
        first = (frame -1)*(frameLength/2)+1;
        last = first+frameLength -1;
        
        estimateFrames = speechData(first:last);
        [magSpec,phaseSpec, test] = audio_passed2(estimateFrames);
        
        noise_mat(frame,:) =  magSpec;
    end
    
    noise_estimate = zeros(1,length(magSpec));
    for i = 1 : length(magSpec)
        noise_estimate(i) = mean(noise_mat(:,i));
    end
    
    

    
    for frame = 1:numFrames


        %1, 320
        first = (frame -1)*(240)+1
        last = first+frameLength -1

                if last>numSamples
            break
        end
        shortTimeFrame = speechData(first:last);
        
%       populate vector with energy of features
        energy = sum(shortTimeFrame(1:(frameLength/2)).^2);
        [shortTimeMag,shortTimePhase,test2] = audio_passed2(shortTimeFrame);
        shortTimeMag = shortTimeMag';
        [newMagSpec] = speech_enhancement(shortTimeMag,noise_estimate, test2);


%         
%       if (last+(frameLength/2))+(last+(160))>numSamples
%       end
%         

        halfMag = newMagSpec(1:(length(newMagSpec)/2));
%       use mel Triangular  filterbank
        mfccCos = melFiltTriangular(halfMag,numChan);
        
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
    writeMFCC(mat_vec,'speech001Gun.mfc', numChan)
% end
end
     
    