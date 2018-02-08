function [ value, n_agents_exclusive ] = avg_s_around( x, y, state, opts )
%AVG_S_AROUND Average agent value around x, y

[l, h] = nb_range_for(x, y, opts);
is_occupied = nb_occupants_for(x, y, state, opts);

% Zoom in to the neighbourhood
nb_s = state.s(l(1):h(1), l(2):h(2));

% The house at x, y might be occupied, subtract either way
% s is 0 when it is not occupied!
sum_s_exclusive = sum(nb_s(is_occupied)) - state.s(x, y);

% Total number of agents is the sum of occupied houses
% Correct for the house at x,y (boolean is 1 when true!)
n_agents_exclusive = sum(sum(is_occupied)) - (state.id(x, y) ~= 0);

value = sum_s_exclusive / n_agents_exclusive;

if isnan(value)
    value = 0;
end

end

