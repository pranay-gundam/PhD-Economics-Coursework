# Loading in package files
include("agents.jl")

# Creating basic primitives to use


# Testing Agent creation and modification
A1 = make_Agent("Bob", 0.5, log)
A2 = make_Agent("Bobby", 0.999, sqrt)

@assert get_name(A1) == "Bob"
@assert get_name(A2) == "Bobby"

@assert get_temporal_discount(A1) == 0.5
@assert get_temporal_discount(A2) == 0.999

@assert get_utility_func(A1) == log
@assert get_utility_func(A2) == sqrt

@assert get_utility_func(A1)(exp(3)) == 3
@assert get_utility_func(A1)(1) == 0

@assert get_utility_func(A2)(4) == 2.0
@assert get_utility_func(A2)(0) == 0

# Testing Job Search object creation and modification


println("All tests passed!")