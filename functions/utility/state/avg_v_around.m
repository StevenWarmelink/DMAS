function [ value, n_houses_exclusive ] = avg_v_around( x, y, state, opts )
%AVG_S_AROUND Average house value around x, y

[l, h] = nb_range_for(x, y, opts);
size = nb_size_for(x, y, opts);
% Zoom in to the neighbourhood
nb_v = state.s(l(1):h(1), l(2):h(2));

sum_v_exclusive = sum(sum(nb_v)) - state.v(x, y);
n_houses_exclusive = size - 1;

value = sum_v_exclusive / n_houses_exclusive;

end