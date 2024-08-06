# Loading in package files
include("includeall.jl")

# Creating basic primitives to use


# Testing Agent creation and modification
A1 = Agent("Bob"; temporal_discount = 0.5, utility_func = log)
A2 = Agent("Bobby"; temporal_discount = 0.999, utility_func = sqrt)

@test get_name(A1) == "Bob"
@test get_name(A2) == "Bobby"

@test get_temporal_discount(A1) == 0.5
@test get_temporal_discount(A2) == 0.999

@test get_utility_func(A1) == log
@test get_utility_func(A2) == sqrt

@test get_utility_func(A1)(exp(3)) == 3
@test get_utility_func(A1)(1) == 0

@test get_utility_func(A2)(4) == 2.0
@test get_utility_func(A2)(0) == 0

# Testing Job Search object creation and modification







# Basic Problem and Value Iteration Testing

## Create the basic problem where the worker is either employed forever or unemployed and draws wages from a distribution
## each time period. There is no quitting. There is also a bounded unemployment benefit.


## Do Value Iteration on the setup above.


## Create graphs with changes in teh reservation wage as the unemployment benefit changes, as the variance of normal
## distribution of wage draws change, are the mean of the wage draws changes.


println("All tests passed!")