function sound_and_haptics_stimuli_matrix = create_sound_and_haptics_cond_stimuli_matrix(STIMULI_FOLDER_PATH, sounds_2_be_played, ...
        condition_type, complexity_level)
% 
% The create_sound_cond_stimuli_matrix function generates a
% matrix of dimensions 363825 (rows) x 8 (columns), representing the 
% specified sound(s) for the SOUND + HAPTICS condition and specified complsxity level. 
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
%       specified sound(s) for the SOUND + HAPTICS condition and specified complexity. 
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
            filename_1  = 'SN_BD';  % sound (ch1 and ch2)
            filename_2  = 'SN_Hap'; % buzz 1 (ch3)
            filename_3  = 'BD_Hap'; % buzz 2 (ch4)
            
            buzz_1_chan = 5; % snare
            buzz_2_chan = 6; % bass drum
            
            audio_3_to_read_path  = strcat(STIMULI_FOLDER_PATH, complexity_level, '_', filename_3, '.wav');
       
        otherwise %snare + hi_hat
            filename_1 = 'SN_only_HH'; % sound (ch1 and ch2)
            filename_2 = 'SN_only_Hap'; % buzz 1 (ch3)
            filename_3 = 'HH_Hap'; % buzz 2 (ch4)
            
            buzz_1_chan = 5; % snare
            buzz_2_chan = 7; % hi-hat
                
            audio_3_to_read_path  = strcat(STIMULI_FOLDER_PATH, filename_3, '.wav');

    end

    audio_1_to_read_path   = strcat(STIMULI_FOLDER_PATH, complexity_level, '_', filename_1, '.wav');
    audio_2_to_read_path   = strcat(STIMULI_FOLDER_PATH, complexity_level, '_', filename_2, '.wav');

    [curr_audio_1,fs]      = audioread(audio_1_to_read_path);
    [curr_audio_2,fs]      = audioread(audio_2_to_read_path);
    [curr_audio_3,fs]      = audioread(audio_3_to_read_path);


elseif num_sounds_to_play == 3 %snare + bass_and_drums + hi_hat
    filename_1             = 'full';
    filename_2             = 'SN_Hap';
    filename_3             = 'BD_Hap';
    filename_4             = 'HH_Hap';
    
    buzz_1_chan = 5; % snare
    buzz_2_chan = 6; % bass drum
    buzz_3_chan = 7; % hi-hat
    
    % TODO turn this into a function - repeated code
    audio_1_to_read_path   = strcat(STIMULI_FOLDER_PATH, complexity_level, '_', filename_1, '.wav');
    audio_2_to_read_path   = strcat(STIMULI_FOLDER_PATH, complexity_level, '_', filename_2, '.wav');
    audio_3_to_read_path   = strcat(STIMULI_FOLDER_PATH, complexity_level, '_', filename_3, '.wav');
    audio_4_to_read_path   = strcat(STIMULI_FOLDER_PATH, filename_4, '.wav'); % HH has always same complexity
    
    [curr_audio_1,fs]      = audioread(audio_1_to_read_path);
    [curr_audio_2,fs]      = audioread(audio_2_to_read_path);
    [curr_audio_3,fs]      = audioread(audio_3_to_read_path);
    [curr_audio_4,fs]      = audioread(audio_4_to_read_path);


else %only one sound - snare 
   filename_1     = 'SN_only';
   filename_2     = 'SN_only_Hap';
           
   audio_1_to_read_path   = strcat(STIMULI_FOLDER_PATH, complexity_level, '_', filename_1, '.wav');
   audio_2_to_read_path   = strcat(STIMULI_FOLDER_PATH, complexity_level, '_', filename_2, '.wav');
        
   [curr_audio_1,fs]      = audioread(audio_1_to_read_path);
   [curr_audio_2,fs]      = audioread(audio_2_to_read_path);
   
   buzz_1_chan            = 5;
end

stimuli_matrix            = zeros(size(curr_audio_1, 1),8);

% TODO - change channel according to haptics instrument


% matrix to be played
if num_sounds_to_play == 2 % 2 sounds (same sound x 2 - ch1, ch2) + 2 buzzes (ch3, ch4)

    stimuli_matrix(:,1)            = curr_audio_1(:,1); 
    stimuli_matrix(:,2)            = curr_audio_1(:,1); 
    stimuli_matrix(:, buzz_1_chan) = curr_audio_2(:,1); % TODO
    stimuli_matrix(:, buzz_2_chan) = curr_audio_3(:,1); 

elseif num_sounds_to_play == 3 % 3 sounds (same sound x 2 - ch1, ch2) + 3 buzzes (ch3, ch4, ch5)
   
    stimuli_matrix(:,1)            = curr_audio_1(:,1); 
    stimuli_matrix(:,2)            = curr_audio_1(:,1);
    stimuli_matrix(:,buzz_1_chan)  = curr_audio_2(:,1); 
    stimuli_matrix(:,buzz_2_chan)  = curr_audio_3(:,1); 
    stimuli_matrix(:,buzz_3_chan)  = curr_audio_4(:,1); 

else %one buzz only | 1 sound (same sound x 2 - ch1, ch2) + 1 buzz (ch3)
    stimuli_matrix(:,1)            = curr_audio_1(:,1);
    stimuli_matrix(:,2)            = curr_audio_1(:,1);
    stimuli_matrix(:,buzz_1_chan)  = curr_audio_2(:,1); 

end

%disp('The matrix matching the file(s) for the SOUND and HAPTICS condition stimuli that you want to play is now created!')
sound_and_haptics_stimuli_matrix = stimuli_matrix;


end 
