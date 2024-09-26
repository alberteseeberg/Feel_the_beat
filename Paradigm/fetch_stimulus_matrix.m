function matrix_2_be_fetched = fetch_stimulus_matrix(stimuli_matrices_struct_array, stimulus_num)
% 
% The fetch_stimulus_matrix function fetches the matrix matching the
% specified stimulus number, so that it can then be played.

% PARAMETERS 
% stimuli_matrices_struct_array : struct array
%       Structure array containing 39 fields that match the 39 different
%       stimuli. 
%
% stimulus_num                  : double
%       Number of the stimulus.
%
% RETURNS 
% matrix_2_be_fetched           : double
%       Matrix of 363825 (rows) x 6 (columns) dimensions representing the
%       specified stimulus number.
%
% Alberte Seeberg, 2023
% PhD student @ Department of Clinical Medicine, Center for Music in the Brain
% Aarhus University, Denmark

field_name               = strcat('stimulus_num_', num2str(stimulus_num));
size_of_stimulus_field   = size(getfield(stimuli_matrices_struct_array, field_name));
stimulus_matrix_position = size_of_stimulus_field(1);
matrix_2_be_fetched      = getfield(stimuli_matrices_struct_array, field_name, ...
    {stimulus_matrix_position});

end

