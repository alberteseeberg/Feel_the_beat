function move_rating_val = do_the_move_rating(xCenter, yCenter, win)
% 
% The do_the_move_rating function is used to display the rating scale for
% the 'Urge to move' evaluation (goes from 0 to 100). The rating value (move_rating_val) is
% returned, so that it can be later saved in a struct array. 
%
% Alberte Seeberg, 2023
% PhD student @ Department of Clinical Medicine, Center for Music in the Brain
% Aarhus University, Denmark

% Parameters for your scale and text that you want
question       = 'Hvor meget gav denne rytme dig lyst til at bevæge dig?';
lowerText      = 'Slet ikke';
upperText      = 'Virkelig meget';
pixelsPerPress = 2;
waitframes     = 1;
lineLength     = 500; % pixels
halfLength     = lineLength/2; 
divider        = lineLength/100; % for a rating of 1:10

baseRect       = [0 0 10 30]; % size of slider
LineX          = xCenter;
LineY          = yCenter;

rectColor      = [0 0 0]; % color for slider
lineColor      = [0 0 0]; % color for line
textColor      = [0 0 0]; % color for text

Screen('TextFont',win, 'Helvetica');  % font parameters
Screen('TextSize',win, 32);
Screen('TextStyle', win, 0);

% set up what keys you want to use
KbName('UnifyKeyNames');
RightKey    = KbName('RightArrow');
LeftKey     = KbName('LeftArrow');
ResponseKey = KbName('Space');
%escapeKey   = KbName('esc');

% escapeKey = KbName('ESCAPE');

% Actual bit that draws the scale
% while KbCheck; end

while true
    
    [keyIsDown, secs, keyCode] = KbCheck;
    pressedKeys = find(keyCode);
    
%     if strcmp(pressedKeys == escapeKey)
%         break
    if keyCode(LeftKey)
        LineX = LineX - pixelsPerPress;
        
    elseif keyCode(RightKey)
        LineX = LineX + pixelsPerPress;
        
    elseif pressedKeys == ResponseKey
        StopPixel_M = ((LineX - xCenter) + halfLength)/divider; % for a rating of between 0 and 10. Tweak this as necessary.
        break;
    end
    
    if LineX < (xCenter-halfLength)
        LineX = (xCenter-halfLength);
    elseif LineX > (xCenter+halfLength)
        LineX = (xCenter+halfLength);
    end
    if LineY < 0
        LineY = 0;
    elseif LineY > (yCenter+10)
        LineY = (yCenter+10);
    end
    
    centeredRect  = CenterRectOnPointd(baseRect, LineX, LineY);
  
    currentRating = ((LineX - xCenter) +  halfLength)/divider;  %
    ratingText    = num2str(currentRating); % to make this display whole numbers, use "round(currentRating)"

    DrawFormattedText(win, ratingText ,'center', (yCenter-200), textColor, [],[],[],5); % display current rating 
    DrawFormattedText(win, question ,'center', (yCenter-100), textColor, [],[],[],5);
    
    Screen('DrawLine', win,  lineColor, (xCenter+halfLength ), (yCenter),(xCenter-halfLength), (yCenter), 1);
    Screen('DrawLine', win,  lineColor, (xCenter+halfLength ), (yCenter +10), (xCenter+halfLength), (yCenter-10), 1);
    Screen('DrawLine', win,  lineColor, (xCenter-halfLength ), (yCenter+10), (xCenter- halfLength), (yCenter-10), 1);
    
    Screen('DrawText', win, lowerText, (xCenter-halfLength*1.5), (yCenter+25),  textColor);
    Screen('DrawText', win, upperText , (xCenter+halfLength) , (yCenter+25), textColor);
    Screen('FillRect', win, rectColor, centeredRect);
    %vbl = Screen('Flip', win, vbl + (waitframes - 0.5) *  slack);
    Screen('Flip', win)
%     check_pressed_keys_v2();
end

% Save ratings to struct, instead of file to not mess with the flow of the
% experiment
move_rating_val = StopPixel_M;

end