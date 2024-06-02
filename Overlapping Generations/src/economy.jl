include("households.jl")

struct Economy
    # Households 
    households::Vector{Household}

    # Number of households
    Hs::Int

    # Number of periods
    Ts::Int

    # Number of goods
    Gs::Int

end


function make_Economy(households::Vector{Household}, Hs::Int, Ts::Int, Gs::Int)
    return Economy(households, Hs, Ts, Gs)
end


# Personal Note: Equilibrium consists of an asset allocation, prices, and a
#                consumption allocation  
function find_equilibrium(e::Economy)
    # This function will find the equilibrium of the economy
    # given the households in the economy
    return 0
end