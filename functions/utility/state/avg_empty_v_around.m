function [ value, n_ocu_houses_exclusive ] = avg_empty_v_around( x, y, state, opts )
%AVG_S_AROUND Average house value around x, y

[l, h] = nb_range_for(x, y, opts);
is_occupied = nb_occupants_for(x, y, state, opts);
size = sum(sum(~is_occupied));

% All houses are occupied, return 0
if size == 0
   value = 0;
   n_ocu_houses_exclusive = 0;
   return;
end

% Zoom in to the neighbourhood
nb_v = state.s(l(1):h(1), l(2):h(2));

sum_ocu_v = sum(sum(nb_v(~is_occupied)));

if state.id(x, y) == 0
   sum_ocu_v_exclusive = sum_ocu_v - state.v(x, y);
   n_ocu_houses_exclusive = size - 1;
else
   sum_ocu_v_exclusive = sum_ocu_v;
   n_ocu_houses_exclusive = size;
end

if n_ocu_houses_exclusive == 0
   value = 0;
   return;
end

value = sum_ocu_v_exclusive / n_ocu_houses_exclusive;

end