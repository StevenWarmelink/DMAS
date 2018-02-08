function [ is_moving, x, y ] = should_move_in( p_move_in, is_potential_house, opts )
%SHOULD_MOVE_IN Determing whether to move in and where

% Default is false
is_moving = false;
x = 0;
y = 0;

% Roll the dice
values = rand(opts.g_dims);

% Decision per house based on p_move_in
decision = values < p_move_in;
% Sanity check
decision(~is_potential_house) = 0;

[xs, ys] = find(decision);

if isempty(xs)
    return; 
end

% Select which house if multiple are possible
is_moving = true;
idx = datasample(1:length(xs), 1);
x = xs(idx);
y = ys(idx);

end

