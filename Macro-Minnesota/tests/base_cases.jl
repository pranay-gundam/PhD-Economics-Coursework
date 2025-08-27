# The classic include all for everything that we need
include("../src/Macro_Minnesota.jl")

using Macro_Minnesota

p = Parameter(:alpha, 0.5, "Example parameter")
println(p)
