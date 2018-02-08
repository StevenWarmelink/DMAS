function res = get_n_agents()
    global n_agents
    
    if isempty(n_agents)
       set_n_agents(1)
       warning('Initialized agentCount to 1')
       res = 1; % TODO: Needed?
       return
    end
    
    res = n_agents;
end

