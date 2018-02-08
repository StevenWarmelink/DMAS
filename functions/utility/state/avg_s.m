function [ value ] = avg_s( state, opts )
%AVG_S average agent value in the entire city

value = sum(sum(state.s)) / prod(opts.g_dims);

end

