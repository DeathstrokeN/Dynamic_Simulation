function truncatedSignal = truncateSignalq(inputSignal)
    factor = 10^6; % For six decimal places
    temp = inputSignal * factor; % Scale up the signal
    temp = temp - mod(temp, 1); % Subtract the remainder of division by 1 to truncate
    truncatedSignal = temp / factor; % Scale back down
end

% function truncatedSignal = truncateSignal(inputSignal)
%     strSignal = sprintf('%.9f', inputSignal); % Convert to string with sufficient precision using sprintf
%     decimalPointIndex = strfind(strSignal, '.'); % Find the decimal point
%     if ~isempty(decimalPointIndex)
%         truncatedStrSignal = strSignal(1:(decimalPointIndex + 6)); % Keep up to six digits after decimal
%         truncatedSignal = str2double(truncatedStrSignal); % Convert back to number
%     else
%         truncatedSignal = inputSignal; % No decimal point, return original signal
%     end
% end
