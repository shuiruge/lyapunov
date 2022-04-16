

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


abstract type Solver{T} end
function solve(
    ::Solver{T},
    ::StochasticDynamics{T},
    ::AbstractArray{T, N},
    ::T
)::AbstractArray{T, N} where {T, N}
end
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
function solve(m::EulerMethod, d, x, t)
    μ = zero.(x)
    f!(d, μ, x, t)

    Σ = zero.(x)
    g!(d, Σ, x, t)
    W = sqrt.(Σ) .* randn(size(x)...)

    μ .* m.dt .+ W .* sqrt(m.dt)
end


function solve!(m::EulerMethod, d, x, t)
    x .= solve(m, d, x, t)
end