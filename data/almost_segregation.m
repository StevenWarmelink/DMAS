% Default start-up script for DMAS project

%% Set options

opts = struct();

% --- Output
opts.file_name = '.almost_segregation.csv';
opts.show_moving_message = false;

% --- Settings
opts.n_epochs = 100;                 % n_ = number of
opts.n_agents = 2000;
opts.n_immigrants = 150;           
opts.g_dims = [50, 50];              % g_ = grid (i.e. entire city)
opts.nb_dim = 5;                     % nb_ = neighbourhood

% --- Parameters
% Determine the initialization strategy
% Uniform initialization (select one)
% opts.init_strategy = 'uniform';      % Indicate uniform mode
% opts.init_params = [...
%     0.1 .5;...                          % Lower and upper bound for v_ and s_
%     0.1 .5 ...                          % Lower and upper bound for g_
% ];
opts.init_strategy = 'normal';       % Indicate normal mode
opts.init_params = [...
    0.4  0.6;...                     % means of 2 distributions
    0.06 0.06 ...                    % sigmas of 2 distributions
];
% Factor with which the value of a house decays when it is not occupied
opts.v_decay = 0.8;                  % v_ = house value
% Factor of the house value that an agent pays in order to live in the
% house
opts.m_factor = 2;                   % m_ = morgage
% Agent value threshold for which agents consider moving out of the city
opts.s_limit = 0.1;                  % s_ = agent value
% Determines the update strategy used for the agent value
% Possible values: linear, logistic
opts.s_update = 'linear';
% Determines the probability of leaving the system when:
% - the agent value is lower than s_limit
% - the agent moved out, but could not move in somewhere else
opts.p_leave = 0.7;                 % p_ = probability
% Weights for the moving probability function
opts.w_move_out = [-0.01 0.01 4];    % w_ = weights
opts.w_move_in = [0 0.5 -4];
opts.h_criteria = [0 opts.m_factor]; % h_ = house


%% Initialize matlab things

% Add all source-files to the path
addpath(genpath('.'))


%% Initialze simulation

% Check if output file exists
if exist(opts.file_name, 'file') == 2
    warning('removing old data-file!');
end

names = ['"x",',...
         '"y",',...
         '"house value",' ...
         '"agent id",',...
         '"agent value",',...
         '"agent growth-rate",',...
         '"neighbourhood value",',...
         '"neighbourhood tension",',...
         '"neigbhourhood size",',...
         '"prob move out",' ...
         '"epoch"'];
fid = fopen(opts.file_name,'w');
fprintf(fid,'%s\r\n',names);
fclose(fid);

% Make sure every simulation starts with ID 1
set_n_agents(1);
state = make_empty_state(opts);   % Allocation
state = fill_state(state, opts);  % Initialization

% Write initial state
write_state(state, opts, 0);

%% Simulate

for e = 1:opts.n_epochs
    show_message(e, state, opts);
    
    % Run the migration logic for every agents
    state = process_agent_migration(state, opts);
    state = process_agent_immigration(state, opts);
    
    % Update the economic model
    state = update_economics(state, opts);
  
    % Write the output of this timestep
    
    % Write to file
    write_state(state, opts, e);
end
