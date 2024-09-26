% channels_decrypting
% 
% The channels_decrypting script was created to understand the sound card's
% channels settings, in order to know exactly to what channel each speaker
% and motor of the haptics wearable device corresponds.
% 
% Alberte Seeberg, 2023
% PhD student @ Department of Clinical Medicine, Center for Music in the Brain
% Aarhus University, Denmark

fs  = 48000; %TODO

PsychPortAudio('Close')

InitializePsychSound
deviceID = 18;
devices  = PsychPortAudio('GetDevices');
devices(deviceID+1)

test_file_path    = 'C:\Users\stimuser\Desktop\Alberte_CI_Groove\stimuli\L_SN_only_Hap.wav';
[curr_audio_1,fs] = audioread(test_file_path);
dummy_mat         = zeros(size(curr_audio_1, 1), 8);
dummy_mat(:,8)    = curr_audio_1;
paHandle          = PsychPortAudio('Open',deviceID,[],[],fs,8,64);

PsychPortAudio('FillBuffer',paHandle, dummy_mat')

PsychPortAudio('Start',0) % play that jam!


% WaitSecs(10)
% PsychPortAudio('Close',0) % play that jam!

