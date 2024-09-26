function ci_groove_eeg_info_struct = run_eeg_experiment_v2(participantID, block_1_files, block_2_files, block_3_files, block_4_files, block_5_files, ci_groove_study_all_stimuli_struct)
% 
% The run_eeg_experiment_v2 function is invoked in the
% main_script_ci_groove_study_eeg_exp and it is connected to the EEG, by
% sending it triggers when the different stimuli start playing and also
% storing all the important information (triggers, current condition and 
% instrument combos) in a struct array (ci_groove_eeg_info_struct) that is
% the output of this function.
%
% Alberte Seeberg, 2023
% PhD student @ Department of Clinical Medicine, Center for Music in the Brain
% Aarhus University, Denmark
PsychPortAudio('Close'); %close PsychPortAudio
% Define audio settings
fs          = 48000;
InitializePsychSound
deviceID    = 18;
devices     = PsychPortAudio('GetDevices');
devices(deviceID+1);
paHandle    = PsychPortAudio('Open',deviceID,[],[],fs,8,64); % open sound 
sendTrigger = intialiseParallelPort(); % opening connection to EEG stuff

ci_groove_eeg_info_struct = struct();
trial_counter             = 1;
sendTrigger(0);

while true

    Screen('Preference', 'SkipSyncTests', 0); % Only use this line for debugging purposes
    [win, rect] = Screen('OpenWindow', 0);
    
    Screen('TextFont',win, 'Helvetica');  % font parameters
    Screen('TextSize',win, 32);
    Screen('TextStyle', win, 0);

    HideCursor;
    
    % Present the instructions and wait for a key press to start the experiment
    DrawFormattedText(win, ['I denne del af eksperimentet vil vi bede dig om at lytte til og mærke rytmerne.\n' ...
    ' \n' ...
    'Du skal ikke gøre noget udover at lytte og mærke, men vi vil bede dig om at prøve at fokusere på rytmerne.\n' ...
    ' \n' ...
    'Vi vil også bede dig om at sidde så stille som muligt. \n' ...
    ' \n' ...
    'Der vil være fem runder, og indimellem runderne, vil der være en pause. \n' ...
    ' \n' ...
    'I pausen må du bevæge dig, og pausen kan vare så længe, som du har brug for. \n' ...
    ' \n' ...
    'Tryk på en tast, når du er klar til at starte eksperimentet.'], 'center', 'center', [1 1 1]);
    Screen('Flip', win);
    KbWait;
    
    ListenChar(1)
    
    check_pressed_keys_v2(); % Checking for 'esc' key presses 

    % Let's play some groovy stimuli!
    for curr_idx = 1:5
        
        audio_files = eval(['block_', num2str(curr_idx), '_files']); %fetching the current block's files
        
        for i = 1:length(audio_files) % 4 blocks of 55 and last with 53
            
            check_pressed_keys_v2();  % Checking for 'esc' key presses

            % fetching the current trial stimulus
            stim              = strcat('stimulus_num_', num2str(audio_files(i))); %stimulus number 2b fetched from struct
            stim_field_handle = getfield(ci_groove_study_all_stimuli_struct, stim);
            curr_matrix       = stim_field_handle{4,1}; % curr trial matrix (4th sub-sub-field of struct)
            trig_val          = stim_field_handle{5,1}; % curr trigger value (5th sub-sub-field of struct)
            
            % setting up the screen view
            DrawFormattedText(win, ' ', 'center', 'center');
            Screen('Flip', win);
            WaitSecs(0.5);
            
            % setting up the sound playing
            PsychPortAudio('FillBuffer', paHandle, curr_matrix');
            PsychPortAudio('Start', paHandle);
            
            % sending trigger to EEG
            curr_time_stamp = datetime(now,'ConvertFrom','datenum');
            %display(str2num(trig_val)); %proxy for trigger
            sendTrigger(str2num(trig_val)); % SEND TRIGGER HERE

            start_time = GetSecs;
            
            check_pressed_keys_v2(); % Checking for 'esc' key presses 
            
            while GetSecs - start_time < length(curr_matrix)/fs
                DrawFormattedText(win, '+', 'center', 'center');
                Screen('Flip', win);
                
                check_pressed_keys_v2(); % Checking for 'esc' key presses 
            end
            
            %display(0); %reset trigger
            sendTrigger(0); %RESET TRIGGER HERE 

            % Saving stuff in the struct
            field_name    = strcat('participant_num_', num2str(participantID), '_trial_', num2str(trial_counter));
            struct_values = {stim_field_handle{1,1}; stim_field_handle{2,1}; stim_field_handle{3,1}; trig_val; curr_time_stamp};
            ci_groove_eeg_info_struct = setfield(ci_groove_eeg_info_struct, field_name, struct_values);
            trial_counter             = trial_counter + 1;
            
        end
    
        if curr_idx < 5
            
            % Present the instructions and wait for a key press to start the experiment
            DrawFormattedText(win, 'Nu er der pause. Vent venligst.', 'center', 'center', [1 1 1]);
            Screen('Flip', win);
            KbWait;
        end
        
        % Present the instructions and wait for a key press to start the experiment
        DrawFormattedText(win, 'Nu er der pause. Vent venligst.', 'center', 'center', [1 1 1]);
        Screen('Flip', win);
        KbWait;
        
        

    end
    
    % Present the instructions and wait for a key press to start the experiment
    DrawFormattedText(win, 'Denne del af forsøget er nu slut. Vent venligst.', 'center', 'center', [1 1 1]);
    Screen('Flip', win);
    KbWait;
    
    Screen('CloseAll');
    
    return
end

