using Distributions
using PDMats


"""
dx = μ dt + dW, <dW, dW> = Σ dt

where μ is the mean of the stochastic process, and Σ the covariance matrix.

Here we assume that covariance matrix is diagonal. Thus Σ is the diagonal part
of the covariance matrix, thus is a vector.

The μ and Σ are inplace computed by `f!` and `g!` respectively.
"""
abstract type StochasticDynamics{T} end
function f!(
    ::StochasticDynamics{T},
    ::AbstractArray{T, N},
    ::AbstractArray{T, N},
    ::T
)::AbstractArray{T, N} where {T, N}
end
function g!(
    ::StochasticDynamics,
    ::AbstractArray{T, N},
    ::AbstractArray{T, N},
    ::T
)::AbstractArray{T, N} where {T, N}
end
function initΣ(
    ::StochasticDynamics{T},
    ::AbstractArray{T}
)::AbstractPDMat{T} where T
end


abstract type Solver{T} end
function solve!(
    ::Solver{T},
    ::StochasticDynamics{T},
    ::AbstractArray{T, N},
    ::T
)::AbstractArray{T, N} where {T, N}
end


struct EulerMethod{T} <: Solver{T} where T
    dt::T
end


"""
Implements the Euler method of solving the stochastic dynamics during [0, t].
"""
function solve!(d::StochasticDynamics, x, t; method::EulerMethod)
    τ = zero(t)
    μ = zero.(x)
    Σ = initΣ(d, x)
    dt = method.dt

    while τ < t
        f!(d, μ, x, τ)
        g!(d, Σ, x, τ)
        d = MvNormal(μ * dt, Σ * dt)
        x .+= rand(d, size(x))
        τ += dt
    end
end
