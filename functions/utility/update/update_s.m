function [ new_state ] = update_s( state, opts )
%UPDATE_S Selects which s update function to use

if strcmp(opts.s_update,  'logistic')
    new_state = update_s_log(state, opts);
elseif strcmp(opts.s_update,  'linear')
    new_state = update_s_lin(state, opts);
else
    error('Unknown s_update value');
end

end

