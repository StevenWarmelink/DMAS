function [ values ] = gen_v_values( opts )
%INIT_V Generates initial house values

if strcmp(opts.init_strategy, 'uniform')
    values = opts.init_params(2,1) + (opts.init_params(2,2) - opts.init_params(2,1)) .* rand(opts.g_dims);
elseif strcmp(opts.init_strategy,  'normal')
    % Generate from the first distribution
    v1 = normrnd(opts.init_params(1, 1), opts.init_params(1, 2), opts.g_dims);
    % Generate from the second distribution
    v2 = normrnd(opts.init_params(2, 1), opts.init_params(2, 2), opts.g_dims);
    % Allocate
    values = zeros(opts.g_dims);
    % Select which to use where
    dist = randi(2, opts.g_dims);   % Generates 1 or 2 randomly.
    values(dist == 1) = v1(dist == 1);
    values(dist == 2) = v2(dist == 2);
    
    values = clamp(0, values, 1);
else
    error('Unknown init_strategy');
end

end