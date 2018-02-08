function [ state ] = update_economics( state, opts )
% UPDATE_ECONOMICS run the update functions

% Have to use state in both because the old v and s are required
state_v = update_v(state, opts);
state_s = update_s(state, opts);

% Write the changes
state.v = state_v.v;
state.s = state_s.s;

% The new state information is required here!
state = update_nb_v(state, opts);
state = update_nb_t(state, opts);
state = update_p_move_out(state, opts);

end

