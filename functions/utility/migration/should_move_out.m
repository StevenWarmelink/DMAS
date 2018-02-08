function [ is_moving ] = should_move_out( state, opts )
%SHOULD_MOVE_OUT For all agents determines whether they move out

% Find occupied cells
is_occupied = g_occupants(state);

% Roll the dice
values = rand(opts.g_dims);

% Set all empty cells to 1
values(~is_occupied) = 1;

% Check if the value is lower than the probability an agent moves
values(is_occupied) = values(is_occupied) >= state.p_move_out(is_occupied);

% Invert 0 and 1 to get the agents that move as 'true'
is_moving = ~values;

end

