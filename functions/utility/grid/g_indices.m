function [ indices ] = g_indices( opts )
%G_INDICES Returns all x-y pairs for the grid

[x, y] = meshgrid(1:opts.g_dims(1), 1:opts.g_dims(2));
indices = [x(:), y(:)];
end

