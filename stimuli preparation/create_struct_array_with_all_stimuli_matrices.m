function struct_array_with_all_stimuli_info = create_struct_array_with_all_stimuli_matrices(STIMULI_FOLDER_PATH, CONDITION_TYPES, ...
    COMPLEXITY_LEVELS, INTRUMENT_COMBOS)
% 
% The create_struct_array_with_all_stimuli_matrices function generates a
% struct array (struct_array_with_all_stimuli_info) with all the possible 
% stimuli combinations. 
%
% PARAMETERS 
% CONDITION_TYPES   : string array
%       List of the three conditions (["sound", "haptics", "sound_and_haptics"]).
%
% COMPLEXITY_LEVELS : string array
%       List of the three complexity levels (["L", "M", "H"]).
%
% INTRUMENT_COMBOS  : cell array
%       List of the possible instruments combinations ({"snare", ["snare" "bass_drum"], 
% ["snare" "hi_hat"], ["snare" "bass_drum" "hi_hat"]}).
%
% RETURNS 
% struct_array_with_all_stimuli_info    : struct array
%       Structure array containing 39 fields that match the 39 different
%       stimuli.
%
% ? Alberte Seeberg, 2023
% PhD student @ Department of Clinical Medicine, Center for Music in the Brain
% Aarhus University, Denmark

num_conditions          = length(CONDITION_TYPES);
num_complexity_levels   = length(COMPLEXITY_LEVELS);
num_instruments_combos  = length(INTRUMENT_COMBOS);

stimuli_no_counter      = 1;
ci_groove_experiment_all_stimuli_struct = struct();

for condition_num = 1:num_conditions %iterating conditions
    %fprintf('------\n')
    %fprintf('CONDITION    : %s \n', CONDITION_TYPES(condition_num))
    
    switch  condition_num
        case 1 %sound
            cond_trig_val = 0;
            
        case 2 %haptics
            cond_trig_val = 1;
            
        otherwise % 3 - sound + haptics
            cond_trig_val = 2;
    end

    for complexity_level = 1:num_complexity_levels %iterating complexities
        %fprintf("COMPLEXITY   : %s \n", COMPLEXITY_LEVELS(complexity_level))
        
        switch  complexity_level
            case 1 %low
                compl_trig_val = 1;

            case 2 %medium
                compl_trig_val = 2;

            otherwise % 3 - high
                compl_trig_val = 3;
        end
        
        for instrument_combo_num = 1:num_instruments_combos %iterating instruments combos
            current_cell = INTRUMENT_COMBOS(instrument_combo_num);
            
            switch  instrument_combo_num
                case 1 %snare
                    instr_trig_val = 1;

                case 2 %snare + bass_drum
                    instr_trig_val = 2;

                case 3 %snare + hi_hat 
                    instr_trig_val = 3;
                    
                otherwise %full
                    instr_trig_val = 4;
            end
            
            if instrument_combo_num > 1 % more than 1 sound
                instrument_1 = current_cell{1,1}(1);
                instrument_2 = current_cell{1,1}(2);
              
                if size(current_cell{1,1}, 2) == 2 % 2 sounds
                    instrument_combo_id = strcat(instrument_1,'+',instrument_2);
                else % 3 sounds
                    instrument_3        = current_cell{1,1}(3);
                    instrument_combo_id = strcat(instrument_1,'+',instrument_2, '+', instrument_3);
                end
            else % 1 sound
                    instrument_combo_id = INTRUMENT_COMBOS(instrument_combo_num);
            end
            %fprintf("INSTRUMENT(S): %s \n", string(instrument_combo_id))
            curr_stimuli_matrix = create_stimuli_matrix_to_be_played(STIMULI_FOLDER_PATH, current_cell, ...
                char(CONDITION_TYPES(condition_num)), char(COMPLEXITY_LEVELS(complexity_level)));
            
            curr_trigger_num    = strcat(num2str(cond_trig_val), num2str(compl_trig_val), num2str(instr_trig_val)); % TODO
            
            % saving stuff in the struct array
            struct_values = {char(CONDITION_TYPES(condition_num)); 
                char(COMPLEXITY_LEVELS(complexity_level)); char(instrument_combo_id); curr_stimuli_matrix; curr_trigger_num};
            field_name = strcat('stimulus_num_', num2str(stimuli_no_counter));
            %field_name = num2str(stimuli_no_counter);
            ci_groove_experiment_all_stimuli_struct = setfield(ci_groove_experiment_all_stimuli_struct, field_name, struct_values);
            
            stimuli_no_counter = stimuli_no_counter + 1;

        end
    end
end

metronome_stimuli_no_counter = 37; %number of fields already created + 1
metronome_trig_values_lst    = {'055'; '155'; '255'};
% adding metronome matrices to the struct (in fields 37, 38 and 39)
for condition_num = 1:num_conditions
    metronome_sound_stimuli_matrix = create_metronome_stimuli_matrix_to_be_played(STIMULI_FOLDER_PATH, CONDITION_TYPES(condition_num));
    curr_metronome_trigger_num     = char(metronome_trig_values_lst(condition_num));
    % saving stuff in the struct array
    struct_values                           = {char(CONDITION_TYPES(condition_num)); 'baseline'; 'metronome'; metronome_sound_stimuli_matrix; curr_metronome_trigger_num};
    field_name                              = strcat('stimulus_num_', num2str(metronome_stimuli_no_counter));
    ci_groove_experiment_all_stimuli_struct = setfield(ci_groove_experiment_all_stimuli_struct, field_name, struct_values);
    metronome_stimuli_no_counter            = metronome_stimuli_no_counter + 1;
end

struct_array_with_all_stimuli_info = ci_groove_experiment_all_stimuli_struct;

end