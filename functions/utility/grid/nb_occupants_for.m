function [ is_occupied ] = nb_occupants_for( x, y, state, opts )
%NB_OCCUPANTS_FOR locations of occupied houses in nb of x,y

[low, high] = nb_range_for(x, y, opts);
is_occupied = state.id(low(1):high(1), low(2):high(2)) ~= 0;

end

