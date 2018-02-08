function [ value ] = avg_v( state, opts )
%AVG_S average house value in the entire city

value = sum(sum(state.v)) / prod(opts.g_dims);

end
