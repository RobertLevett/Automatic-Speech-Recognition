function [upsampled_visual_features] = upSample(visual_features)
visual_features= visual_features';
audio_fs = .01; % 20 ms
visual_fs = 1/29.97; % 33 ms (29.97fps)
 audio_Hz = 1/audio_fs; % 50H
 visual_Hz = 1/visual_fs; % 29.97fps/Hz
 
 % x_axis of visual features in seconds 
visual_features_x = (1:size(visual_features,2))/visual_Hz; 

% plot visual features 
subplot(2,1,1); 
plot(visual_features_x, visual_features(1,:), 'bx-'); 
xlabel('visual feature Time (seconds)')

% Upsample visual features to match sample rate of audio features 
upsampled_visual_features = resample(visual_features', visual_features_x, audio_Hz)'
% x_axis of upsampled visual features in seconds 
upsampled_visual_features_x = (1:size(upsampled_visual_features,2))/audio_Hz;

% plot upsampled visual features 
subplot(2,1,2); 
plot(upsampled_visual_features_x, upsampled_visual_features(1,:), 'rx-');
xlabel('upsample Time (seconds)')
end


