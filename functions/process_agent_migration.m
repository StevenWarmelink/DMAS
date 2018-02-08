function [ state ] = process_agent_migration( state, opts )
%PROCESS_AGENT_MIGRATION run the migration logic for each agent

% Boolean state for each cell
is_moving = should_move_out(state, opts);
is_occupied = g_occupants(state);
cells = g_indices(opts);

% loop over the grid
for idx = 1:length(cells)
    x = cells(idx, 1);
    y = cells(idx, 2);
    
    % Empty houses cannot move
    if ~is_occupied(x, y)
        continue;
    end
    
    if is_moving(x, y)
        % Agent is moving
        is_potential_house = find_potential_houses(state.s(x, y), state, opts);
        p_move_in = evaluate_house_for_agent(is_potential_house, state.s(x, y), state, opts);
        [is_moving_in, nx, ny] = should_move_in(p_move_in, is_potential_house, opts);
        if is_moving_in
            state = move_agent(x, y, nx, ny, state, opts);
        else
            % Cannot find a house, check for leaving
            if should_leave_city(opts)
                state = remove_agent(x, y, state, opts); 
                if opts.show_moving_message
                    disp(' ');
                end
            end
        end
    else
        % Agent is not moving, check its economic status
        if state.s(x, y) < opts.s_limit && should_leave_city(opts)
            state = remove_agent(x, y, state, opts); 
            if opts.show_moving_message
                disp(' ');
            end
        end
    end
end

end

