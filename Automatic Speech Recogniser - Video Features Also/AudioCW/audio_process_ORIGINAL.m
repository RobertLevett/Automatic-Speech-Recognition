function [] = audio_process_ORIGINAL(speechFile)

% for k = 1:9
%     speechFile = strcat('speech01', num2str(k), '.wav');
%     mfccName = strcat('speech01', num2str(k), '.mfc');
%     
    speechData = audioread(speechFile);
    numSamples = length(speechData);
    frameLength = 320;
    numFrames = floor(numSamples/(frameLength/2)-1);

    mat_vec = zeros(numFrames, 33);
     featureVec  = [];

    for frame = 1:numFrames

        first = (frame -1)*(272)+1;
        last = first+frameLength -1;
        if last>numSamples
            break
        end

        shortTimeFrame = speechData(first:last);
        [shortTimeMag,shortTimePhase] = audio_passed(shortTimeFrame);

%         subplot(1,3,1);
%         plot(shortTimeMag);
%         xlim([0 320]);
%         title('Magnitude')
%         xlabel('Frequency (Bins)')
%         ylabel('Magnitude')
%         subplot(1,3,3);
%         
%         
%         plot(shortTimePhase);
%         xlim([0 320]);
%         title('Phase')
%         xlabel('Frequency (Bins)')
%         ylabel('Phase')




    %     
    %     shift1 = first+(frameLength/2)
    %     shift2 = last+(frameLength/2)
    %  
%         shortTimeFrame2 = speechData(shift1:shift2);
%         [shortTimeMag2,shortTimePhase2] = audio_passed(shortTimeFrame2);
%         
%         subplot(2,2,1);
%         plot(shortTimeMag2);
%         subplot(2,2,2);
%         plot(shortTimePhase2);


        halfMag = shortTimeMag(1:(length(shortTimeMag)/2));
        mfccCos = melFiltSquare(halfMag,10);

        mat_vec(frame, 1:10) = mfccCos;
        mat_vec(frame, 31:31) =  sum(mat_vec(frame,1:10).^2);

    %     keyboard

        featEnergy = sum(mat_vec(1:10));


        featureVec = [featureVec; mfccCos];    

    %%%%%%%%%%%%%%%%%%%

%         subplot(1,3,2);
%         plot(halfMag);
%         xlim([0 160]);
%         title('Half of Magnitude')
%         xlabel('Frequency (Bins)')
%         ylabel('Magnitude')
%         subplot(2,2,4);
%         plot(mfccCos);
%         pause(eps)
%     %     pause(eps); 
%         drawnow;
    end

    for vec = 1:numFrames

       if vec == 1 
           mat_vec(vec, 11:20) = mat_vec(vec+1, 1:10) - mat_vec(vec, 1:10);
       elseif vec == numFrames  
           mat_vec(vec, 11:20) = mat_vec(vec, 1:10) - mat_vec(vec-1, 1:10);
       else
           mat_vec(vec, 11:20) = mat_vec(vec+1, 1:10) - mat_vec(vec-1, 1:10);
       end
        mat_vec(vec, 32:32) =  sum(mat_vec(vec,11:20).^2);
    end



    for vec = 1:numFrames

       if vec == 1 
           mat_vec(vec, 21:30) = mat_vec(vec+1, 11:20) - mat_vec(vec, 11:20);

       elseif vec == numFrames
           mat_vec(vec, 21:30) = mat_vec(vec, 11:20) - mat_vec(vec-1, 11:20);

       else
           mat_vec(vec, 21:30) = mat_vec(vec+1, 11:20) - mat_vec(vec-1, 11:20);

       end
        mat_vec(vec, 33:33) = sum(mat_vec(vec,21:30).^2);   
    %     keyboard
    end



    %write to the file
    writeMFCC(mat_vec,'speech020.mfc')
% end
end
     