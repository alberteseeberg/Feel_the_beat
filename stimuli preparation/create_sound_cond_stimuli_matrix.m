function sound_cond_stimuli_matrix = create_sound_cond_stimuli_matrix(STIMULI_FOLDER_PATH, sounds_2_be_played, condition_type, complexity_level)
% 
% The create_sound_cond_stimuli_matrix function generates a
% matrix of dimensions 363825 (rows) x 8 (columns), representing the 
% specified sound(s) for the SOUND condition and specified complexity level. 
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
%       Matrix of 363825 (rows) x 8 (columns) dimensions representing the
%       specified sound(s) for the SOUND condition and specified complexity. 
%
% Alberte Seeberg, 2023
% PhD student @ Department of Clinical Medicine, Center for Music in the Brain
% Aarhus University, Denmark

if strcmp(sounds_2_be_played{1,1}, 'snare')
    num_sounds_to_play  = 1;
    
else
    num_sounds_to_play  = length(sounds_2_be_played{1,1});
end
    
%num_sounds_to_play      = size(sounds_2_be_played{1,1}, 2);

if num_sounds_to_play == 2 %snare + bass_and_drums OR snare + hi_hat
    switch char(sounds_2_be_played{1,1}(2))
        case 'bass_drum' %snare + bass_and_drums
            concat_sound_filename_str = strcat('SN', '_', 'BD');
       
        otherwise %snare + hi_hat
            concat_sound_filename_str = strcat('SN_only', '_', 'HH');
    end

elseif num_sounds_to_play == 3 %snare + bass_and_drums + hi_hat
    concat_sound_filename_str = 'full';

else %only one sound - snare 
    concat_sound_filename_str = 'SN_only';

end

audio_to_read_path       = strcat(STIMULI_FOLDER_PATH, complexity_level, '_', ...
    concat_sound_filename_str, '.wav');
[curr_audio,fs]          = audioread(audio_to_read_path);
%fs = 48000;
% matrix to be played
stimuli_matrix           = zeros(size(curr_audio, 1),8);
stimuli_matrix(:, 1)     = curr_audio(:,1); % sound - channel 1
stimuli_matrix(:, 2)     = curr_audio(:,1); 

sound_cond_stimuli_matrix = stimuli_matrix; 

%disp('The matrix matching the file(s) for the SOUND condition stimuli that you want to play is now created!')

end 
