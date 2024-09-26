function matrix_to_be_played = create_stimuli_matrix_to_be_played(STIMULI_FOLDER_PATH, sounds_2_be_played, condition_type, complexity_level)
% 
% The create_stimuli_matrix_to_be_played function generates a
% matrix of dimensions 363825 (rows) x 8 (columns), representing the 
% specified sound(s) for the specified condition and complexity. 
%
% PARAMETERS 
% sounds_2_be_played  : string / string array
%       Instrument(s) to be played.
%
% condition_type      : string
%       Condition type (['sound', 'haptics', 'sound_and_haptics']).
%
% complexity_level    : string
%       Complexity level (['sound', 'haptics', 'sound_and_haptics']).
%
% RETURNS 
% matrix_to_be_played  : double
%       Matrix of 363825 (rows) x 8 (columns) dimensions representing the
%       specified sound(s) for the specified condition and complexity. 
%
% Alberte Seeberg, 2023
% PhD student @ Department of Clinical Medicine, Center for Music in the Brain
% Aarhus University, Denmark

if strcmp(condition_type, 'sound') % SOUND condition
    all_stimuli_combos_for_sound_cond   = create_sound_cond_stimuli_matrix(STIMULI_FOLDER_PATH, sounds_2_be_played, ...
        condition_type, complexity_level);
    matrix_to_be_played = all_stimuli_combos_for_sound_cond;

elseif strcmp(condition_type, 'haptics') % HAPTICS condition 
    all_stimuli_combos_for_haptics_cond = create_haptics_cond_stimuli_matrix(STIMULI_FOLDER_PATH, sounds_2_be_played, ...
        condition_type, complexity_level);
    matrix_to_be_played = all_stimuli_combos_for_haptics_cond;

else % SOUND and HAPTICS condition
    all_stimuli_combos_for_sound_and_haptics_cond = create_sound_and_haptics_cond_stimuli_matrix(STIMULI_FOLDER_PATH, sounds_2_be_played, ...
        condition_type, complexity_level);
    matrix_to_be_played = all_stimuli_combos_for_sound_and_haptics_cond;
end

end