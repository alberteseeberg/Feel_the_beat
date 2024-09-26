function [] = check_pressed_keys_v2()
% 
% The check_pressed_keys_v2 function checks if the ESCAPE key was pressed
% at some point in time and, if that is/was the case, it interrupts the
% experiment and closes the experiment's screen. 
%
% Alberte Seeberg, 2023
% PhD student @ Department of Clinical Medicine, Center for Music in the Brain
% Aarhus University, Denmark

% Check for any key presses
KbName('UnifyKeyNames');

[keyIsDown, Secs, keyCode] = KbCheck;

key_down_lst  = any(keyCode == 1); %any key pressed (=1)?

if key_down_lst % if any key was pressed (key_down_lst = 1 = true)
%     display('Keys were pressed!')
    key_codes_lst = KbName(keyCode); %cell array containing names of pressed keys

    esc_key_values_lst = any(strcmp(key_codes_lst,'ESCAPE')); %check if any of the pressed keys was 'esc'
    
    if esc_key_values_lst % if any of the pressed keys was 'esc' (esc_key_values_lst = 1 = true)
%         PsychPortAudio('Stop', paHandle); % not stopping before the entire duration of the stimuli is played TODO
        Screen('CloseAll');
         display('The esc key was pressed!')
    end  

end