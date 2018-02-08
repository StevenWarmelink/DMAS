function [ new_state ] = update_nb_v( state, opts )
%UPDATE_NB_V computes the neighbourhood value based on houses and agents

% copy state
new_state = state;

% compute neighbourhood value for each neighbourhood 
centers = g_indices(opts);
f = @(x, y) nb_value_for(x, y, state, opts);
new_state.nb_v = vec2mat(arrayfun(f, centers(:,1), centers(:,2)), opts.g_dims(2));

end

