function [ low, high ] = nb_range_for( x, y, opts )
%NB_INDICES_FOR Returns the nb x and y range for x and y

size = floor(opts.nb_dim / 2);
low_x = max(1, x - size);
high_x = min(opts.g_dims(1), x + size);
low_y = max(1, y - size);
high_y = min(opts.g_dims(2), y + size);

low = [low_x, low_y];
high = [high_x, high_y];

end

