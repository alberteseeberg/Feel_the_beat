function saving_rating_status = save_rating_as_csv(participantID)
% 
% The save_rating_as_csv function is invoked in the
% main_script_ci_groove_study_exp_rating and it is responsible for saving 
% the ci_groove_ratings_info_struct_all_trials struct of the specified 
% participant (participantID) to a CSV file (to be further analysed in R).
%
% Alberte Seeberg, 2023
% PhD student @ Department of Clinical Medicine, Center for Music in the Brain
% Aarhus University, Denmark

OUTPUT_FOLDER = 'C:\Users\stimuser\Desktop\Alberte_CI_Groove\rating_data\';

% Load participant that you want
load([OUTPUT_FOLDER, num2str(participantID), '.mat'])

for participant_trial_number = 1:52 %39 before with three blocks
    
    %disp(num2str(participant_trial_number))
    
    for i = 2:9
        participant_tag   = ['participant_num_', participantID, '_trial_', num2str(participant_trial_number)];
        %disp(participant_tag)
        part_field_handle = getfield(ci_groove_ratings_info_struct_all_trials, participant_tag);
        new_mat(1)        = part_field_handle(1);
        new_val           = part_field_handle(i);
%         disp(new_val)

        new_mat(i)        = new_val;
        %disp(new_mat(i))

    end
    all_trials_mat(participant_trial_number,:) = new_mat; 
    ratings = all_trials_mat;

end

cell2table(ratings);
writetable(cell2table(all_trials_mat), [OUTPUT_FOLDER, participantID, '.csv']);

saving_rating_status = 'Successfully saved!';
disp(saving_rating_status)

end