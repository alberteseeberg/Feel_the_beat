% main_script_ci_groove_study_stimuli_prep
% 
% The main_script_ci_groove_experiment_stimuli_prep script has TWO MAIN GOALS:
% 
%  1. Create (and save) a struct array with 39 fields that represent all 
% the stimuli that will be played to the participants.
%
%  2. Allow one to test (play) the stimulus of a specific single trial.
% 
% Some important context:
%  -> CONDITIONS         : 3 (sound, haptics, sound + haptics)
%  -> COMPLEXITY LEVELS  : 3 (low, medium, high)
%  -> INSTRUMENTS COMBOS : 4 (snare, snare + bass_drum, snare + hi_hat, 
% snare + bass_drum + hi_hat) 
% 
%   * Each instrument combo is played for all 3 complexity levels, for all
%   conditions (4 x 3 x 3 = 36 stimuli).
%   * There is another 'instrument combo', which ONLY contains a metronome.
%   Each metronome combo is played for all conditions, but the complexity
%   is always the same (1 x 3 = 3 stimuli).
%
% So, 36+3 = 39 stimuli <-> number of fields of the struct
% 
% OUTPUTS 
% ci_groove_study_all_stimuli_info.mat : MAT-file
%       All experiment's stimuli info, stored in a struct array, saved to a MAT-file.
%
% Alberte Seeberg, 2023
% PhD student @ Department of Clinical Medicine, Center for Music in the Brain
% Aarhus University, Denmark

%% 0. Set path 
%cd 'C:\Users\stimuser\Desktop\Alberte_CI_Groove\scripts\'
STIMULI_FOLDER_PATH = 'C:\Users\stimuser\Desktop\Alberte_CI_Groove\stimuli\';

%% 1. Creating variables with the instruments combos, complexity levels and condition types
INTRUMENT_COMBOS        = {'snare', {'snare' 'bass_drum'}, {'snare' 'hi_hat'}, {'snare' 'bass_drum' 'hi_hat'}};
METRONOME_SOUND_CASE    = 'metronome';
COMPLEXITY_LEVELS       = {'L' 'M' 'H'}; %low, medium, high
CONDITION_TYPES         = {'sound', 'haptics', 'sound_and_haptics'};

%% 2. Creating the struct array with all possible combos (3 conditions | 3 complexity levels | all instruments combos)
% generating all stimuli matrices (if the struct has not been generated yet)
fprintf('1. Creating struct array with matrices for all stimuli \n -----\n')

if exist('ci_groove_study_all_stimuli_struct','var')
    %fprintf('Struct array already created. Check ' + ...
    %    'ci_groove_study_all_stimuli_struct variable in the Workspace.\n\n')

else %create struct
    ci_groove_study_all_stimuli_struct = create_struct_array_with_all_stimuli_matrices(STIMULI_FOLDER_PATH, CONDITION_TYPES, ...
    COMPLEXITY_LEVELS, INTRUMENT_COMBOS);
    %fprintf('Struct array with matrices for all stimuli created! - Check variable ' + ...
    %    'ci_groove_study_all_stimuli_struct. \n\n')
end

%% 3. Saving the stimuli information as a .mat file
fprintf('2. Saving the stimuli information as a .mat file \n -----\n')

save('ci_groove_study_all_stimuli_info.mat', 'ci_groove_study_all_stimuli_struct')
fprintf('The struct array is now saved as a MAT-file!\n\n')

% %% 4. Fetching (and playing) a specific stimulus
% 
% load ('ci_groove_study_all_stimuli_info.mat')
% stimulus_num                  = 20; % cond: sound, compl: L, instruments: snare+hi_hat
% stimuli_matrices_struct_array = ci_groove_study_all_stimuli_struct;
% 
% % device_connection_need_msg    = msgbox('Please make sure the sound device is connected, otherwise ' + ...
% %     'step 3 crashes.');
% 
% fprintf('3. Fetching (and playing) a specific stimulus \n -----\n')
% % fetching the stimulus matrix from the struct array
% disp('Fetching the matrix to be played...')
% 
% matrix_2_be_fetched = fetch_stimulus_matrix(stimuli_matrices_struct_array, ...
%     stimulus_num);
% 
% % playing the matrix 
% disp('Setting up the sound...')
% disp('Let there be music!')
% play_the_stimulus_matrix = play_stimulus_matrix(matrix_2_be_fetched{1, 1});
% 
% fprintf('\n The end\n')


