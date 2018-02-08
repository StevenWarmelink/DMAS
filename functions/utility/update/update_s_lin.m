function [ new_state ] = update_s_lin( state, opts )
%UPDATE_V Compute next house values

% copy state
new_state = state;

% find occupied houses;
is_occupied = g_occupants(state);

% Set agent value to 0 on empty houses
new_state.s(~is_occupied) = 0;
% Update agent value
new_state.s(is_occupied) = ...
    clamp(0,...
        state.s(is_occupied) +...
        state.g(is_occupied) -...
        opts.m_factor * state.v(is_occupied) ...
    , 1);

end
