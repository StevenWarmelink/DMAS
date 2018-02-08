function [ value ] = gen_s_value( opts )
%INIT_V Generates initial house values

if strcmp(opts.init_strategy, 'uniform')
    value = opts.init_params(2,1) + (opts.init_params(2,2) - opts.init_params(2,1)) .* rand(1, 1);
elseif strcmp(opts.init_strategy,  'normal')
    % Select which distribution to use where
    dist = randi(2, 1, 1);   % Generates 1 or 2 randomly.
    % Generate the value
    value = normrnd(opts.init_params(1,dist), opts.init_params(2,dist));
    value = clamp(0, value, 1);
else
    error('Unknown init_strategy');
end

end