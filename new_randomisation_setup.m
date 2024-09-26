% new_randomisation_setup
% 
% The new_randomisation_setup script was created to redo the way the
% stimuli are presented to the participants (specifically in the EEG and 
% tapping parts, where all conditions' trials are randomised and a situation 
% of a sound + sound + sound_and_haptics + haptics sequence can happen). 
% 
% Alberte Seeberg, 2023
% PhD student @ Department of Clinical Medicine, Center for Music in the Brain
% Aarhus University, Denmark

all_trials_vector      = repelem(1:39, 7);

all_trials_lst         = all_trials_vector(randperm(length(all_trials_vector)));
block_1_files          = all_trials_lst(1:55);
block_2_files          = all_trials_lst(56:110);
block_3_files          = all_trials_lst(111:165);
block_4_files          = all_trials_lst(166:220);
block_5_files          = all_trials_lst(221:273);

test                   = [block_1_files, block_2_files, block_3_files, block_4_files, block_5_files];
unique_elements_in_lst = unique(test);
