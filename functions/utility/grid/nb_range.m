function [ low, center, high ] = nb_range( opts )
%NB_RANGE Ranges of all neighbourhoods in the city

center = g_indices(opts);
[low, high] = nb_range_for(center(:,1), center(:,2), opts);

end

