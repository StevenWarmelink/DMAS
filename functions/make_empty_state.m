function state = make_empty_state( opts )
%MAKEAGENT Generate default empty state

if nargin ~= 1
   error('Options struct required') 
end

zero = zeros(opts.g_dims);

state = struct();
state.id = zero;                % Agent id
state.v = zero;                 % House value
state.s = zero;                 % Agent economic status
state.g = zero;                 % Agent growth rate
state.nb_v = zero;              % Neighbourhood value
state.nb_t = zero;              % Neighbourhood tensions (for agent id)
state.nb_s = zero;              % Neighbourhood size for each location
state.p_move_out = zero;        % Probability of moving out for each agent
end

