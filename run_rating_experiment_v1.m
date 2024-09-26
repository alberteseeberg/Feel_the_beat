function ci_groove_ratings_info_struct_all_trials = run_rating_experiment_v1(participantID, condition, block_order, block1_files, block2_files, block3_files, ci_groove_study_all_stimuli_struct)
% 
% The run_rating_experiment_v1 function is invoked in the
% main_script_ci_groove_study_exp_rating and it is responsible for performing
% the urge to move and listening pleasure ratings, while also
% storing all the important information (rating values, current condition and 
% instrument combos) in a struct array (ci_groove_ratings_info_struct_all_trials) that is
% the output of this function.
%
% Alberte Seeberg, 2023
% PhD student @ Department of Clinical Medicine, Center for Music in the Brain
% Aarhus University, Denmark

ci_groove_ratings_info_struct = struct();

% Define audio settings
fs            = 48000;
InitializePsychSound
deviceID      = 18;
devices       = PsychPortAudio('GetDevices');
devices(deviceID+1);
paHandle      = PsychPortAudio('Open',deviceID,[],[],fs,8,64);

trial_counter = 1;

while true
    
    % Screen parameters. You'll probably want to call these at the top of your script
    screenNumber = max(Screen('Screens'));
    Screen ('Preference', 'SkipSyncTests', 1);
    Screen ('Preference', 'VisualDebugLevel', 1);

    PsychImaging('PrepareConfiguration');
    PsychImaging('AddTask', 'General', 'NormalizedHighresColorRange'); % Make colours be from 0 to 1
    [win, rect] = Screen('OpenWindow', 0); 
    
    Screen('TextFont',win, 'Helvetica');  % font parameters
    Screen('TextSize',win, 32);
    Screen('TextStyle', win, 0);
    
    HideCursor;
    
    [xCenter, yCenter] = RectCenter(rect);

    
    % Present the instructions and wait for a key press to start the experiment
    DrawFormattedText(win, ['I denne del af eksperimentet vil vi bede dig om at lytte til og mærke rytmerne.\n' ...
    ' \n' ...
    'Efter hver rytme, vi vil bede dig om at bedømme rytmen i forhold til, hvor meget\n' ...
    ' \n' ...
    'den gav dig lyst til at bevæge dig samt hvor stor en fornøjelse det var at lytte til/mærke den.\n' ...
    ' \n' ...
    'Med lyst til at bevæge sig, mener vi al bevægelse, dermed  ikke kun lyst til at danse, men også\n' ...
    ' \n' ...
    'lyst til at vippe med hovedet, tappe med fingeren, foden, eller lignende. \n' ...
    ' \n' ...
    'Tryk på space for at fortsætte.'], 'center', 'center', [1 1 1]);
    Screen('Flip', win);
    KbWait;

    
    DrawFormattedText(win, ['Bedømmelserne laves på en skala fra 0-100, hvor 0 = slet ikke/ingen fornøjelse og 100 = virkelig meget/stor fornøjelse. \n' ...
    ' \n' ...
    'Du rykker markøren ved hjælp af højre og venstre piletast. \n' ...
    ' \n' ...
    'Når du er tilfreds med placeringen af markøren, bruger du space bar til at vælge denne placering. \n' ...
    ' \n' ...
    'Vi vil opfordre dig til at bruge hele skalaen i forsøget, og sammenholde rytmerne med hinanden\n' ...
    ' \n' ...
    'frem for at sammenholde dem med rigtig musik. \n' ...
    ' \n' ...
    'Tryk på space for at fortsætte.'], 'center', 'center', [1 1 1]);
    Screen('Flip', win);
    WaitSecs(1);
    KbWait; 
    
    DrawFormattedText(win, ['Der vil være fire runder, og indimellem runderne, vil der være en pause. \n' ...
    ' \n' ...
    'Hvis du har nogle spørgsmål, inden du går i gang, så henvend dig gerne til os nu.\n' ...
    ' \n' ...
    'Tryk på en tast, når du er klar til at starte eksperimentet.'], 'center', 'center', [1 1 1]);
    Screen('Flip', win);
    WaitSecs(1);
    KbWait;
    
    ListenChar(1)
    
    check_pressed_keys_v2(); % Checking for 'esc' key presses HERE
  
    % Let's play some groovy stimuli!
    for curr_idx = 1:4

        curr_block = block_order(curr_idx);
        
        switch curr_block
            case 1
                audio_files = block1_files;
            case 2
                audio_files = block2_files;
            otherwise
                audio_files = block3_files;
        end
        
        for i = 1:13 %13 trials per condition (12 instr combos + metronome)
                        
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
            display(trig_val); %proxy for trigger
            
            start_time = GetSecs;
                        
            while GetSecs - start_time < length(curr_matrix)/fs %while sound plays
                DrawFormattedText(win, '+', 'center', 'center');
                Screen('Flip', win);
                
                check_pressed_keys_v2(); % Checking for 'esc' key presses TODO
 
            end
            
            WaitSecs(0.5)
            
            % RATING HERE
            move_rating_val     = do_the_move_rating(xCenter, yCenter, win); %pleasure
            WaitSecs(1)
            pleasure_rating_val = do_the_pleasure_rating(xCenter, yCenter, win); % umm

            
            % Saving stuff in the struct
            field_name    = strcat('participant_num_', num2str(participantID), '_trial_', num2str(trial_counter));
            struct_values = {num2str(condition); num2str(block_order); num2str(curr_block); stim_field_handle{1,1}; stim_field_handle{2,1}; stim_field_handle{3,1}; trig_val; num2str(pleasure_rating_val); num2str(move_rating_val)};
            % ; num2str(move_rating_val) TODO
            ci_groove_ratings_info_struct = setfield(ci_groove_ratings_info_struct, field_name, struct_values);
            trial_counter          = trial_counter + 1;
            
        end
       
                
        if curr_idx < 4
            % Present the instructions and wait for a key press to start the experiment
            DrawFormattedText(win, 'Nu er der pause. Tryk på space, når du er klar til at fortsætte.', 'center', 'center', [1 1 1]);
            Screen('Flip', win);
            
            WaitSecs(2)
            KbWait;

        end

    end
    
    ci_groove_ratings_info_struct_all_trials = ci_groove_ratings_info_struct;

    DrawFormattedText(win, 'Denne del af forsøget er nu slut. Vent venligst.', 'center', 'center', [1 1 1]);
    Screen('Flip', win);
    WaitSecs(5); %seconds

    Screen('CloseAll');
    return
end
% 
% PsychPortAudio('Stop', paHandle);
% PsychPortAudio('Close', paHandle);

end

%