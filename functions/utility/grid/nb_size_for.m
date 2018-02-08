function [ size ] = nb_size_for( x, y, opts )
%NB_SIZE_FOR number of houses in the neighbourhood of x, y

[low, high] = nb_range_for(x, y, opts);
size = prod(high - low + 1);

end

