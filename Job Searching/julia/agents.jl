struct Agent
    name::String
    temporal_discount::Float64
    utility_func::Function
end


function make_Agent(name::String, temporal_discount::Float64, utility_func::Function)
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




 