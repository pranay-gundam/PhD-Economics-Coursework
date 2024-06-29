struct JobSearch
    agents::AbstractVector{Agent}
    statespace::AbstractMatrix{AbstractFloat}
    state_distr::AbstractVector{Distribution}
end

struct value_iteration
    pass
end


function calc_state_prob(state::AbstractVector{AbstractFloat}, state_distr::AbstractVector{Distribution}; 
                         is_independent = true)
    if is_independent
        return prod(map(x,distr -> pdf(distr, x), zip(state, state_distr)))
    end
end

function calc_expectation(statespace::AbstractMatrix{AbstractFloat}, state_distr::AbstractVector{Distribution}, 
                          utility_func::Function)
    expectation = 0.0
    for i = 1:size(statespace)[1]
        expectation += calc_state_prob(statespace[i,:], state_distr) * utility_func(state)
    end
    return expectation
end

function run_VFI!(jb::JobSearch, vi::value_iteration; save_iterations = false)
    if save_iterations
        iterations = []
    end
   
    

end