struct Agent
    name::String
    temporal_discount::AbstractFloat
    utility_func::Function
    unemploy_benefit::AbstractFloat 
end


function Agent(name::String; temporal_discount::Float64 = 0.9, 
                             utility_func::Function = identity, 
                             unemploy_benefit::Float64 = 0.0)
    if temporal_discount < 0 || temporal_discount > 1
        throw(ArgumentError("Temporal discount must be between 0 and 1"))
    end
    return Agent(name, temporal_discount, utility_func, unemploy_benefit)
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

function get_unemploy_benefit(agent::Agent)
    return agent.unemploy_benefit
end



 