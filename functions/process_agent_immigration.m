function [ state ] = process_agent_immigration( state, opts )
%PROCESS_AGENT_IMMIGRATION Perform immigration logic

% Create n immigrants
for idx = 1:opts.n_immigrants
    id = get_n_agents();    % Get the next agent id
    s = gen_s_value(opts);
    g = gen_g_value(opts);
    
    is_potential_house = find_potential_houses(s, state, opts);
    p_move_in = evaluate_house_for_agent(is_potential_house, s, state, opts);
    [is_moving_in, nx, ny] = should_move_in(p_move_in, is_potential_house, opts);
    if is_moving_in
        state = add_agent(nx, ny, id, s, g, state, opts);       
        if opts.show_moving_message
            disp(' ');
        end
        inc_n_agents();    % Increment only when an agent is added    
    end
end

end

