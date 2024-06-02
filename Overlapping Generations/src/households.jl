struct AbstractHousehold
    id::String
    obj_func::Function
    life_length::Int64
    endowment::Array{Int64}
end

function make_AbstractHousehold(id::String, obj_func::Function, life_length::Int, endowment::Array{Int64})
    @assert length(endowment) == life_length
    return AbstractHousehold(id, obj_func, life_length, endowment)
end








struct Household
    id::String
    obj_func::Function
    beliefs::Function
    endowments::Function
    consumption::Vector{Float64}
    utility::Vector{Float64}
end

function make_Household(id::String, obj_func::Function, constraints_set::Function, 
                        beliefs::Function, endowments::Function,
                        consumption::Vector{Float64}, utility::Vector{Float64})
    return Household(id, obj_func, constraints_set, beliefs, endowments, consumption, utility)
end

function get_id(h::Household)
    return h.id
end

function get_obj_func(h::Household)
    return h.obj_func
end

function get_constraints_set(h::Household)
    return h.constraints_set
end

function get_beliefs(h::Household)
    return h.beliefs
end

function get_endowments(h::Household)
    return h.endowments
end

function get_consumption(h::Household)
    return h.consumption
end

function get_utility(h::Household)
    return h.utility
end

function set_id!(h::Household, id::String)
    h.id = id
end

function set_obj_func!(h::Household, obj_func::Function)
    h.obj_func = obj_func
end

function set_constraints_set!(h::Household, constraints_set::Function)
    h.constraints_set = constraints_set
end

function set_beliefs!(h::Household, beliefs::Function)
    h.beliefs = beliefs
end

function set_endowments!(h::Household, endowments::Function)
    h.endowments = endowments
end

function set_consumption!(h::Household, consumption::Vector{Float64})
    h.consumption = consumption
end

function set_utility!(h::Household, utility::Vector{Float64})
    h.utility = utility
end