function set_n_agents(value)
    if nargin ~= 1
       error('Need a value to set the global counter') 
    end
    
    if value < 1
       error('Cannot have fewer than 1 agent')
    end
    
    global n_agents
    n_agents = value;
end

