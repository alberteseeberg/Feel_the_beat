% main_script_ci_groove_exp_rating
% 
% The main_script_ci_groove_exp_rating script is the core of the rating
% part of the study. 
% 
% OUTPUTS 
% ci_groove_ratings_info_struct_all_trials.mat : MAT-file
%       All participant's ratings (urge to move + pleasure) and other 
% important info stored in a struct array, saved to a MAT-file.
%
% participantID.csv                            : CSV file
%       All participant's ratings (urge to move + pleasure) and other 
% important info, exported to a CSV file.
%
% Alberte Seeberg, 2023
% PhD student @ Department of Clinical Medicine, Center for Music in the Brain
% Aarhus University, Denmark

%% 0. Set path 
cd 'C:\Users\stimuser\Desktop\Alberte_CI_Groove\scripts\'
OUTPUT_FOLDER = 'C:\Users\stimuser\Desktop\Alberte_CI_Groove\rating_data\';

%% 1. Loading stimuli (matrices' struct) 
if exist('ci_groove_study_all_stimuli_struct','var')
    fprintf('ci_groove_study_all_stimuli_struct struct already loaded!') 
else
    load('ci_groove_study_all_stimuli_info.mat') %loading the stimuli matrices struct
end

%% 2. Entering participant ID and condition type 
participantID = input('\n\nParticipant ID:', 's'); %'s' specifies a string output
condition     = input('Condition:');

%% 3. Files preparation (and randomisation)
% block1 - sound
block_1_stimuli_cond_nums = [1:12, 37]; 
block1_files              = block_1_stimuli_cond_nums(randperm(length(block_1_stimuli_cond_nums)));

% block 2 - haptics
block_2_stimuli_cond_nums = [13:24, 38];
block2_files              = block_2_stimuli_cond_nums(randperm(length(block_2_stimuli_cond_nums)));
% block 3 - sound + haptics
block_3_stimuli_cond_nums = [25:36, 39]; 
block3_files              = block_3_stimuli_cond_nums(randperm(length(block_3_stimuli_cond_nums)));

% -- Define the order of the blocks based on the condition --
if condition        == 1
    block_order     = [1, 3, 2, 1];
elseif condition    == 2
    block_order     = [3, 1, 2, 1];
else
    error('Invalid condition');
end

%% 4. Experimental run 
% -- Experimental run -- 
PsychPortAudio('Close')

% Running the experiment
ci_groove_ratings_info_struct_all_trials = run_rating_experiment_v1(participantID, condition, block_order, block1_files, block2_files, block3_files, ci_groove_study_all_stimuli_struct);

%% 5. Saving the rating information as a .mat file
fprintf('Saving the rating information as a .mat file \n -----\n')
save([OUTPUT_FOLDER, num2str(participantID),'.mat'], 'ci_groove_ratings_info_struct_all_trials')
fprintf('The struct array is now saved as a MAT-file!\n\n')

%% 6. Saving the ratings information as a .csv file
saving_option = input('\n\nDo you want to save the struct as a CSV file?', 's');
if strcmp(saving_option, 'yes')
    saving_rating_status = save_rating_as_csv(participantID);
end

disp('Finito!')

