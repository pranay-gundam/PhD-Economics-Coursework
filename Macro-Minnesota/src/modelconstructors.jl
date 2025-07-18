abstract type AbstractParameter end
abstract type AbstractModel end


mutable struct Parameter <: AbstractParameter
    name::Symbol
    value::Number
    description::String
end

mutable struct ParameterLarge <: AbstractParameterLarge
    name::Symbol
    value::AbstractArray{Number}
    description::String
end

mutable struct BaseModel
    name::String
    description::String
    parameters::Dict{Symbol, AbstractParameter}
end

function Parameter(name::Symbol, value::Number, description::String)
    return Parameter(name, value, description)
end

function ParameterLarge(name::Symbol, value::AbstractArray{Number}, description::String)
    return ParameterLarge(name, value, description)
end