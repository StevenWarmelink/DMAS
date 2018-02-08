function [ value ] = gen_g_value( opts )
%GEN_G_VALUE Generates initial growthw values

% The bounds are specified in opts when init is uniform
if strcmp(opts.init_strategy, 'uniform')
    value = opts.init_params(2,1) + (opts.init_params(2,2) - opts.init_params(2,1)) * rand(1,1);
    return;
end

% init_strategy is normal from here on
if ~strcmp(opts.init_strategy, 'normal')
    error('Unkown init strategy')
end

% Select the distribution
dist = randi(2, 1, 1); % Generates 1 or 2 randomly.
% Generate a value from that distribution
value = normrnd(opts.init_params(1, dist), opts.init_params(2, dist));
% Make sure we are in the defined range
value = clamp(0, value, 1);

% Check if g is a factor
if strcmp(opts.s_update, 'logistic')
    value = value + 1;
else

end