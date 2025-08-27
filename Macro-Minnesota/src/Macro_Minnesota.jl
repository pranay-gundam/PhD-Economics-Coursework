# Macro-Minnesota.jl
# Basically an include all file for the model and algorithm primitives.

module Macro_Minnesota
    using Distributions
    
    export Parameter, ParameterLarge, PriorParameter, PriorParameterLarge, BaseModel
    export AbstractParameter, AbstractModel, update_param_val!


    include("modelconstructors.jl")    
end
