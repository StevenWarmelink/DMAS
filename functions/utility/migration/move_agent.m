function [ state ] = move_agent( x, y, nx, ny, state, opts )
%DO_MOVE_OUT Move an agent from x,y to nx, ny

id = state.id(x, y);
s = state.s(x, y);
g = state.g(x, y);


if opts.show_moving_message
	disp('Moving:');
end

add_agent(nx, ny, id, s, g, state ,opts);
remove_agent(x, y, state, opts);

if opts.show_moving_message
    disp(' ');
end

end

