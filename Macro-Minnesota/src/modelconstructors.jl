abstract type AbstractParameter{T} end
abstract type AbstractPriorParameter{T,D} <: AbstractParameter{T} end
abstract type AbstractModel end



mutable struct Parameter{N <: Number} <: AbstractParameter{N}
    name::Symbol
    value::N
    description::String
end

mutable struct ParameterLarge{V <: AbstractArray{N}} <: AbstractParameter{V} where N <: Number
    name::Symbol
    value::V
    description::String
end

# Notes on how to do regime switching: 
# The idea about how to do regimes and any other types of parameters are changing the type itself. The key
# is that the function methods themselves don't change in name but are multiple dispatched. IT IS KEY THAT IT
# IS MULTIPLE DISPATCHED BECAUSE IT MAKES THE CODE CLEAN. DON'T PUT A SHITTON OF IF STATEMENTS IN THE function
# ITSELF.

mutable struct PriorParameter{N <: Number, UD <: UnivariateDistribution} <: AbstractPriorParameter{N,D}
    name::Symbol
    value::N
    prior::UD
    description::String
end

mutable struct PriorParameterLarge{V <: AbstractArray{N}, MD <: MultivariateDistribution} <: AbstractPriorParameter{V,D} where N <: Number
    name::Symbol
    value::V
    prior::MD
    description::String
end

mutable struct BaseModel
    name::String
    description::String
    parameters::Dict{Symbol, AbstractParameter}
end

function Parameter(name::Symbol, value::N, description::String) where N <: Number
    return Parameter(name, value, description)
end

function ParameterLarge(name::Symbol, value::V, description::String) where V <: AbstractArray{N} where N <: Number
    return ParameterLarge(name, value, description)
end

# Note here, T can either be a number or an array of numbers.
function update_param_val!(param::AbstractParameter{T}, new_value::T) where T
    param.value = new_value
end