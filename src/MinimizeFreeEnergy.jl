include("Utils.jl")
include("StochasticDynamics.jl")

using Flux


"""
Computes the graident of free energy.
"""
function minfe!(E, x, θ, solver, warmup=false)
    relaxh!(h; m, v, t, dt, T)
    if warmup == false
        updateU!(m; v, h, η, λ, max_gradient_abs)
    end
end
