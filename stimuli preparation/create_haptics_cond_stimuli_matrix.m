function haptics_cond_stimuli_matrix = create_haptics_cond_stimuli_matrix(STIMULI_FOLDER_PATH, sounds_2_be_played, ...
        condition_type, complexity_level)
% 
% The create_haptics_cond_stimuli_matrix function generates a
% matrix of dimensions 363825 (rows) x 6 (columns), representing the 
% specified sound(s) for the HAPTICS condition and specified complexity level. 
%
% PARAMETERS 
% sounds_2_be_played         : string / string array
%       Instrument(s) to be played.
%
% condition_type             : string TODO - unnecessary
%       Condition type (['sound', 'haptics', 'sound_and_haptics']).
%
% complexity_level           : string
%       Complexity level (['sound', 'haptics', 'sound_and_haptics']).
%
% RETURNS 
% sound_cond_stimuli_matrix  : double
%       Matrix of 363825 (rows) x 6 (columns) dimensions representing the
%       specified sound(s) for the HAPTICS condition and specified complexity. 
%
% Alberte Seeberg, 2023
% PhD student @ Department of Clinical Medicine, Center for Music in the Brain
% Aarhus University, Denmark

if strcmp(sounds_2_be_played{1,1}, 'snare')
    num_sounds_to_play  = 1;
    
else
    num_sounds_to_play  = length(sounds_2_be_played{1,1});
end


if num_sounds_to_play == 2 %snare + bass_and_drums OR snare + hi_hat
    switch char(sounds_2_be_played{1,1}(2))
        case 'bass_drum' %snare + bass_and_drums
            filename_1 = 'SN_Hap';
            filename_2 = 'BD_Hap';
            audio_2_to_read_path   = strcat(STIMULI_FOLDER_PATH, complexity_level, '_', filename_2, '.wav');
            
            buzz_1_chan = 5;
            buzz_2_chan = 6;
       
        otherwise %snare + hi_hat
            filename_1 = 'SN_only_Hap';
            filename_2 = 'HH_Hap';
            audio_2_to_read_path   = strcat(STIMULI_FOLDER_PATH, filename_2, '.wav');

            buzz_1_chan = 5;
            buzz_2_chan = 7;
    end
    
    audio_1_to_read_path   = strcat(STIMULI_FOLDER_PATH, complexity_level, '_', filename_1, '.wav');

    [curr_audio_1,fs]      = audioread(audio_1_to_read_path);
    [curr_audio_2,fs]      = audioread(audio_2_to_read_path);


elseif num_sounds_to_play == 3 %snare + bass_and_drums + hi_hat
    filename_1             = 'SN_Hap';
    filename_2             = 'BD_Hap';
    filename_3             = 'HH_Hap';
    
    buzz_1_chan = 5;
    buzz_2_chan = 6;
    buzz_3_chan = 7;

    audio_1_to_read_path   = strcat(STIMULI_FOLDER_PATH, complexity_level, '_', filename_1, '.wav');
    audio_2_to_read_path   = strcat(STIMULI_FOLDER_PATH, complexity_level, '_', filename_2, '.wav');
    audio_3_to_read_path   = strcat(STIMULI_FOLDER_PATH, filename_3, '.wav');

    [curr_audio_1,fs]      = audioread(audio_1_to_read_path);
    [curr_audio_2,fs]      = audioread(audio_2_to_read_path);
    [curr_audio_3,fs]      = audioread(audio_3_to_read_path);


else %only one sound - snare 
    filename_1             = 'SN_only_Hap';
    buzz_1_chan            = 5;
    audio_1_to_read_path   = strcat(STIMULI_FOLDER_PATH, complexity_level, '_', filename_1, '.wav');
    [curr_audio_1,fs]      = audioread(audio_1_to_read_path);
end

stimuli_matrix             = zeros(size(curr_audio_1, 1),8);

% matrix to be played
if num_sounds_to_play == 2
    stimuli_matrix(:, buzz_1_chan)    = curr_audio_1(:,1); 
    stimuli_matrix(:, buzz_2_chan)    = curr_audio_2(:,1); 

elseif num_sounds_to_play == 3
    stimuli_matrix(:, buzz_1_chan)    = curr_audio_1(:,1); 
    stimuli_matrix(:, buzz_2_chan)    = curr_audio_2(:,1); 
    stimuli_matrix(:, buzz_3_chan)    = curr_audio_3(:,1); 

else %one buzz only
    stimuli_matrix(:,buzz_1_chan)    = curr_audio_1(:,1); 
end

%disp('The matrix matching the file(s) for the HAPTICS condition stimuli that you want to play is now created!')
haptics_cond_stimuli_matrix = stimuli_matrix;

end 
