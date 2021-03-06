% Example data file; matrix with 4 columns: time, x-coordinate,
% y-coordinate, and `value'. 

%use dummy file
%filename = 'data.csv';
%use file generated by simulation
filename = 'data/test.csv';

% Show user intructions
displayCommands();

% Read csv, assuming no header
data = csvread(filename,1,0);


dataColumn = 7;


% Biggest value for time; number of steps to visualize
max_t = max(data(:,11));

max_val = min(100,max(data(:,dataColumn)));
min_val = max(-100,min(data(:,dataColumn)));

% City grid dimensions: N*N
dimensions = max(data(:,1));

% Visualization speed: in frames/sec
speed = 1;

economicalMode = true;

x_coord = 1.0;
y_coord = 1.0;

% get(gcf,'CurrentCharacter) reads the most recently pressed character on
% the focus window. The set variant overwrites this so that the user is not
% indefinitely prompted. For each time step, check if there is new user
% input. If so, act accordingly. Regardless of user input, draw new
% visualization frame. 
for currentTime = 1:max_t
    currkey=get(gcf,'CurrentCharacter'); 
    switch currkey
        case 'c'
            displayCommands('Swapping Model');
            economicalMode = ~economicalMode;
        case 'h'
            displayCommands();
        case 'l'
            displayCommands('');
            x_coord = str2int(input('Input x-coordinate: ','s'));
            y_coord = str2int(input('Input y-coordinate: ','s'));
        case 'a'
            displayCommands('Tracking agent on focus location');
        case '>'
            displayCommands('Increasing simulation speed');
            speed = max(0.1,min(speed * 1.2, 50));
        case '<'
            displayCommands('Decreasing simulation speed');
            speed = min(50,max(speed * 0.8, 0.1));
        otherwise
            currkey=get(gcf,'CurrentCharacter'); 
    end
    % Only gives the values of the current time step to the plot func.
    currentStep = data((data(:,11) == currentTime),:);
    drawGrid(dimensions,currentTime,currentStep,speed,economicalMode,[x_coord, y_coord], max_val, min_val, dataColumn);
    %close(figure(2));
    
    %%%%%%%WORK IN PROGRESS%%%%%%%%% (as is the rest of the visualization tbh)
    %delete h1;
    %figure(2);
    %set(gca,'Visible','off');
    %h1 = text(0,0,strcat('Timestep: ', num2str(currentTime)));
    %h2 = text(0,0.2,strcat('BLABLA: ', num2str(dimensions)));
end
