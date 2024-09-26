% count_in_preparation
% 
% The count_in_preparation script has TWO MAIN GOALs:
% 
%  1. Convert the Count_in.wav and Count_in_Hap.wav (count-in metronome for 
% the tapping experiment) files into three matrices:
%
%  -> sound_count_in_matrix             : matrix that will be append to the 
% beggining of all matrices of the SOUND condition
%
%  -> haptics_count_in_matrix           : matrix that will be append to the 
% beggining of all matrices of the HAPTICS condition
%
%  -> sound_and_haptics_count_in_matrix : matrix that will be append to the 
% beggining of all matrices of the SOUND + HAPTICS condition
%
%  2. Save the matrices' variables in a .mat file ('C:\Users\stimuser\Desktop\Alberte_CI_Groove\scripts\count_in_matrices.mat')
% for later use. 
%
% Alberte Seeberg, 2023
% PhD student @ Department of Clinical Medicine, Center for Music in the Brain
% Aarhus University, Denmark

STIMULI_FOLDER_PATH       = 'C:\Users\stimuser\Desktop\Alberte_CI_Groove\stimuli\';

count_in_sound_filename   = 'Count_in_2.wav';
count_in_haptics_filename = 'Count_in_Hap.wav';

empty_mat = zeros(96000, 8);
% Sound - ch1, ch2
[sound_count_in,fs]      = audioread([STIMULI_FOLDER_PATH, count_in_sound_filename]);
empty_mat(:,1)           = sound_count_in;
empty_mat(:,2)           = sound_count_in;
sound_count_in_matrix    = empty_mat;

% Haptics
empty_mat = zeros(96000, 8);
[haptics_count_in,fs]    = audioread([STIMULI_FOLDER_PATH, count_in_haptics_filename]);
empty_mat(:,5)           = haptics_count_in;
haptics_count_in_matrix  = empty_mat;

% Sound and Haptics
empty_mat                = zeros(96000, 8);
empty_mat(:,1)           = sound_count_in;
empty_mat(:,2)           = sound_count_in;
empty_mat(:,5)           = haptics_count_in;
sound_and_haptics_count_in_matrix = empty_mat;

OUTPUT_FOLDER = 'C:\Users\stimuser\Desktop\Alberte_CI_Groove\scripts\';
save([OUTPUT_FOLDER, 'count_in_matrices.mat'], 'sound_count_in_matrix', 'haptics_count_in_matrix', 'sound_and_haptics_count_in_matrix')











