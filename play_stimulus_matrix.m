function played_matrix = play_stimulus_matrix(matrix_2_be_played)
% 
% The play_stimulus_matrix function plays the matric matching the
% specified stimulus number. 
%
% PARAMETERS 
% matrix_2_be_played            : double
%       Matrix of 363825 (rows) x 6 (columns) dimensions representing the
%       specified stimulus number (previously fetched).
%
% RETURNS 
% None, just sound
% 
% Alberte Seeberg, 2023
% PhD student @ Department of Clinical Medicine, Center for Music in the Brain
% Aarhus University, Denmark

fs       = 48000; %TODO

InitializePsychSound
deviceID = 14;
devices  = PsychPortAudio('GetDevices');
devices(deviceID+1)

paHandle = PsychPortAudio('Open',deviceID,[],[],fs,8,64);

PsychPortAudio('FillBuffer',paHandle, matrix_2_be_played')

PsychPortAudio('Start',0) % play that jam!

played_matrix = matrix_2_be_played;