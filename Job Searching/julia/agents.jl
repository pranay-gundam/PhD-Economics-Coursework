struct Agent
    name::String
    temporal_discount::Float64
    utility_func::Function
end


function Agent(name::String, temporal_discount::Float64, utility_func::Function)
    return Agent(name, temporal_discount, utility_func)
end

function get_name(agent::Agent)
    return agent.name
end

function get_temporal_discount(agent::Agent)
    return agent.temporal_discount
end

function get_utility_func(agent::Agent)
    return agent.utility_func
end

function set_name(agent::Agent, name::String)
    agent.name = name
end

function set_temporal_discount(agent::Agent, temporal_discount::Float64)
    agent.temporal_discount = temporal_discount
end

function set_utility_func(agent::Agent, utility_func::Function)
    agent.utility_func = utility_func
end



 