include("Macro_Minnesota.jl")

mutable struct JobSearchModel <: BaseModel
    name::String
    description::String
    parameters::Dict{Symbol, AbstractParameter}
    endo_states_dict::Dict{Symbol, Integer}
end