function [ new_state ] = update_nb_t( state, opts )
%UPDATE_NB_T computes the neighbourhood tension

% copy state
new_state = state;
is_occupied = g_occupants(state);

new_state.nb_t(~is_occupied) = 0;
new_state.nb_t(is_occupied) = ...
    abs(state.s(is_occupied) - state.nb_v(is_occupied));

end

