function displayCommands(varargin)
    clc;
    if nargin == 0
        disp('Welcome to CITYSIM, an agent-based simulation based on the models by Benenson et al., (2008).');
        disp('Command list | press corresponding key while focus is on window');
        disp(' -h : show this help menu');
        disp(' -m : swap from economic to cultural model');
        disp(' -l : specify a location on which to focus');
        disp(' -a : track the agent on the current location');
        disp(' -> : increase simulation speed');
        disp(' -< : decrease simulation speed');    
    else 
        set(gcf,'CurrentCharacter','@');
        disp(varargin{1});
    end
end