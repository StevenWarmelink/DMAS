function [ is_potential_house ] = find_potential_houses( s, state, opts )
%FIND_POTENTIAL_HOUSES Check the empty houses for a potential new house

is_occupied = g_occupants(state);

% Check if the agent can afford a house
is_potential = s > opts.h_criteria(1) + opts.h_criteria(2) * state.v;

is_potential_house = ~is_occupied & is_potential;

end

