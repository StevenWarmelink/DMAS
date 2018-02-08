function [ sizes ] = nb_size( opts )
%NB_SIZE number of neighbours for each neighbourhood

[l, ~, h] = nb_range(opts);
sizes = prod(h - l + 1, 2);
sizes = vec2mat(sizes, opts.g_dims(2));

end

