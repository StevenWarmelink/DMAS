function [ new_state ] = update_s_log( state, opts )
%UPDATE_V Compute next agent values

% copy state
new_state = state;

% find occupied houses;
is_occupied = g_occupants(state);

% Set agent value to 0 on empty houses
new_state.s(~is_occupied) = 0;
% Update agent value
new_state.s(is_occupied) = ...
    clamp(0, (...
        state.g(is_occupied) .*...
        state.s(is_occupied) .*...
        (1 - state.s(is_occupied)) -...
        opts.m_factor * state.v(is_occupied) ...
    ) / avg_v(state, opts), 1);

end
