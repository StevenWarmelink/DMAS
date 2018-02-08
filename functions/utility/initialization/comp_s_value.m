function [ value ] = comp_s_value( house_value, opts )
%INIT_V Compute initial agent values when a house is selected

% probability to move in to a house is computed with
% p = a + b * exp(c * |nb_v - s|)
% p is 0.5 on average, use to compute s
% s = nb_v +/- log((p - a) / b) / c
% nb_v is not known yet, so use v
% a, b, c are parameters in opts.

range = log((0.5 - opts.w_move_in(1)) / opts.w_move_in(2)) / opts.w_move_in(3);
low = house_value - range;
high = house_value + range;

value = low + (high - low) .* rand(1,1);

end
