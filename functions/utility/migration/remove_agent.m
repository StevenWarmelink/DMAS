function [ state ] = remove_agent( x, y, state, opts )
%REMOVE_AGENT Removes an agent from the simulation

% Sanity check
assert(state.id(x, y) ~= 0);

% Clean agent location
state.id(x, y) = 0;
state.s(x, y) = 0;
state.g(x, y) = 0;

% Message
if opts.show_moving_message
    disp(['Removed agent from (', num2str(x), ',', num2str(y),').']);
end

end

