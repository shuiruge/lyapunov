include("Utils.jl")
include("StochasticDynamics.jl")

using Flux


"""
Implements the stochastic dynamics. C.f. the theorem "Stocastic Dynamics" in the documentation.
"""
struct Langevin{T} <: StochasticDynamics{T}
    ∇E
    K
    divK
    T
end


function f!(d::Langevin, μ, x, t)
    μ .= T * d.divK(x, t) - d.K(x, t) * d.∇E(x)
end


function g!(d::Langevin, Σ, x, t)
    Σ .= 2 * d.T * d.K(x, t)
end


function initΣ(d::Langevin, x)
    d.K(x, 0)
end



"""
Implements the RL algorithm. C.f. the algorithm "RL" in the documentation.

∂E is the gradient of the energy function by θ.
"""
function minfe!(d, x, t, ∂E; solver, warmup)
    solve!(d, x, t; solver)
    if warmup
        nothing
    else
        expect([∂E])
    end
end
