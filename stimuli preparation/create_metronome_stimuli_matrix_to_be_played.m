function metronome_sound_stimuli_matrix = create_metronome_stimuli_matrix_to_be_played(STIMULI_FOLDER_PATH, condition_type)
% 
% The create_metronome_stimuli_matrix_to_be_played function generates a
% matrix of dimensions 363825 (rows) x 6 (columns), representing the 'metronome'
% sound, for either of the three conditions (sound, haptics, sound +
% haptics).
%
% PARAMETERS 
% condition_type                  : string
%       Condition type (['sound', 'haptics', 'sound_and_haptics']).
%
% RETURNS 
% metronome_sound_stimuli_matrix  : double
%       Matrix of 363825 (rows) x 6 (columns) dimensions representing the
%       metronome sound for the specified condition.
%
% Alberte Seeberg, 2023
% PhD student @ Department of Clinical Medicine, Center for Music in the Brain
% Aarhus University, Denmark

if strcmp(condition_type, 'sound') % SOUND condition
    audio_to_read_path      = strcat(STIMULI_FOLDER_PATH, 'Metronome.wav');
    [curr_audio,fs]         = audioread(audio_to_read_path);
    
    % matrix to be played
    stimuli_matrix          = zeros(size(curr_audio, 1),8);

    stimuli_matrix(:,1)     = curr_audio(:,1); 
    stimuli_matrix(:,2)     = curr_audio(:,1); 

elseif strcmp(condition_type, 'haptics') % HAPTICS condition 
    audio_to_read_path      = strcat(STIMULI_FOLDER_PATH, 'Metronome_Hap.wav');
    [curr_audio,fs]         = audioread(audio_to_read_path);
    
    % matrix to be played
    stimuli_matrix          = zeros(size(curr_audio, 1),8);

    stimuli_matrix(:,5)     = curr_audio(:,1); 

else % SOUND and HAPTICS condition
   filename_1     = 'Metronome';
   filename_2     = 'Metronome_Hap';
   
           
   audio_1_to_read_path   = strcat(STIMULI_FOLDER_PATH, filename_1, '.wav');
   audio_2_to_read_path   = strcat(STIMULI_FOLDER_PATH, filename_2, '.wav');
   
        
   [curr_audio_1,fs]      = audioread(audio_1_to_read_path);
   [curr_audio_2,fs]      = audioread(audio_2_to_read_path);
   
    stimuli_matrix        = zeros(size(curr_audio_1, 1),8);

   stimuli_matrix(:,1)    = curr_audio_1(:,1);
   stimuli_matrix(:,2)    = curr_audio_1(:,1);
   stimuli_matrix(:,5)    = curr_audio_2(:,1); 


end

metronome_sound_stimuli_matrix = stimuli_matrix;

end