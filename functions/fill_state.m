function [ state ] = fill_state( state, opts )
%FILLLSTATE Initializes the state's values

if nargin ~=2
    error('State and options input is required');
end

%% House Value [0 1] uniform random
state.v = gen_v_values(opts);
state.nb_s = nb_size(opts);

%% Agent values and ids [0 1] uniform random
if prod(opts.g_dims) < opts.n_agents
   error('Not enough houses for the number of agents'); 
end

if prod(opts.g_dims) == opts.g_dims
   warning('All houses occupied'); 
end

% Sample random cells to occupy
cells = g_indices(opts);
houses = datasample(cells, opts.n_agents, 'Replace', false);

% Write agent ID, agent value and growth rate
for idx = 1:length(houses)
   x = houses(idx,1);
   y = houses(idx,2);
   state.id(x, y) = get_inc_n_agents();
   state.s(x, y) = comp_s_value(state.v(x, y), opts);
   state.g(x, y) = gen_g_value(opts);
end

%% Compute local economic tensions for the initial state

state = update_nb_v(state, opts);
state = update_nb_t(state, opts);
state = update_p_move_out(state, opts);


end

