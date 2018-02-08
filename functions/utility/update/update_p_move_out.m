function [ new_state ] = update_p_move_out( state, opts )
%UPDATE_P_MOVE_OUT Computes the probability that an agent moves out

% Copy state;
new_state = state;

is_occupied = g_occupants(state);
new_state.p_move_out(~is_occupied) = 0;

new_state.p_move_out(is_occupied) = ...
    opts.w_move_out(1) +...
    opts.w_move_out(2) .*...
    exp(opts.w_move_out(3) .* state.nb_t(is_occupied));

end

