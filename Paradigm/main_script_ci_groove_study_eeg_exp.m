% main_script_ci_groove_study_eeg_exp
% 
% The main_script_ci_groove_study_eeg_exp script is the core of the EEG
% recordings part of the study. 
% 
% OUTPUTS 
% ci_groove_eeg_info_struct.mat : MAT-file
%       All participant's EEG log files, containing triggers and other 
% important info stored in a struct array, saved to a MAT-file.
%
% Alberte Seeberg, 2023
% PhD student @ Department of Clinical Medicine, Center for Music in the Brain
% Aarhus University, Denmark

%% 0. Set path + Output folder
cd 'C:\Users\stimuser\Desktop\Alberte_CI_Groove\scripts\'
OUTPUT_FOLDER = 'C:\Users\stimuser\Desktop\Alberte_CI_Groove\logfiles\';

%% 1. Loading stimuli (matrices' struct) 
if exist('ci_groove_study_all_stimuli_struct','var')
    fprintf('ci_groove_study_all_stimuli_struct struct already loaded!') 
else
    load('ci_groove_study_all_stimuli_info.mat') %loading the stimuli matrices struct
end

%% 2. Entering participant ID
participantID = input('\n\nParticipant ID:', 's'); %'s' specifies a string output

%% 3. Files preparation (and randomisation)
ALL_TRIALS_VECTOR = repelem(1:39, 7); %total of 273 trials (13 trials per condition x 3 conditions x 7 times each condition's trial)

% making sure it always randomises (randperm function)
all_trials_lst    = ALL_TRIALS_VECTOR(randperm(length(ALL_TRIALS_VECTOR))); 

block_1_files     = all_trials_lst(1:55); 
block_2_files     = all_trials_lst(56:110);
block_3_files     = all_trials_lst(111:165);
block_4_files     = all_trials_lst(166:220);
block_5_files     = all_trials_lst(221:273); % 53 trials in last block

%% 4. Experimental run 
% PsychPortAudio('Close')

% Running the experiment
ci_groove_eeg_info_struct = run_eeg_experiment_v2(participantID, block_1_files, block_2_files, block_3_files, block_4_files, block_5_files, ci_groove_study_all_stimuli_struct);

%% 5. Saving the EEG information as a .mat file
fprintf('Saving the stimuli information as a .mat file \n -----\n')
save([OUTPUT_FOLDER, num2str(participantID),'.mat'], 'ci_groove_eeg_info_struct')
fprintf('The struct array is now saved as a MAT-file!\n\n')

%%
disp('Finito!')
