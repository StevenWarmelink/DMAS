function [ is_occupied ] = g_occupants( state )
%G_OCCUPANTS Locations of occupied houses

is_occupied = state.id ~= 0;

end

