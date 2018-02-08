function [ value ] = nb_value_for( x, y, state, opts )
%NB_VALUE Neighbourhood value based on agents and houses in the nb

size = nb_size_for(x, y, opts);
% Average agent value in the nb
[avg_nb_s, n_agents] = avg_s_around(x, y, state, opts);
% Average house value of empty houses in nb
[avg_nb_v, n_empty_houses] = avg_empty_v_around(x, y, state, opts);

value = (avg_nb_s * n_agents + avg_nb_v * n_empty_houses) / (size - 1);

% Sanity check
assert(~isnan(value));

end

