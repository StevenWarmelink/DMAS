function [ state ] = add_agent( x, y, id, s, g, state, opts )
%ADD_AGENT Adds an agent at x, y

assert(state.id(x, y) == 0);

state.id(x, y) = id;
state.s(x, y) = s;
state.g(x, y) = g;

if opts.show_moving_message
    disp(['Added agent to (', num2str(x), ',', num2str(y),').']);
end


end

