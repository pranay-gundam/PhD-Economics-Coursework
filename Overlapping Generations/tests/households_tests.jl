# Initializing some helful functions
idn(x::Float64) = x


# Creating the household objects
Hy = make_AbstractHousehold("Hy", idn, 2, [10,0])
Ho = make_AbstractHousehold("Ho", idn, 2, [0,10])


