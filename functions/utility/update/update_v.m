function [ new_state ] = update_v( state, opts )
%UPDATE_V Compute next house values

% copy state
new_state = state;

% find occupied houses;
is_occupied = g_occupants(state);

% Decay houses that are not occupied
new_state.v(~is_occupied) = state.v(~is_occupied) * opts.v_decay;

% compute avg exclusive house value for each neighbourhood
centers = g_indices(opts);
f = @(x, y) avg_v_around(x, y, state, opts);
avg_nb_v_exclusive = vec2mat(arrayfun(f, centers(:,1), centers(:,2)), opts.g_dims(2));

% update occupied houses
new_state.v(is_occupied) = ...
    clamp(0, (...
        state.s(is_occupied) +...
        (state.nb_s(is_occupied) - 1) .* avg_nb_v_exclusive(is_occupied)...
    ) ./ state.nb_s(is_occupied), 1);


end

