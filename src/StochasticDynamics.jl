
"""
Implements the Euler method of solving the stochastic dynamics, τ ∈ [0, t],

dx = μ dτ + dW, <dW, dW> = Σ dτ

where μ is the mean of the stochastic process, and Σ the covariance matrix.

Here we assume that covariance matrix is diagonal. Thus Σ is the diagonal part
of the covariance matrix, thus is a vector.

The μ and Σ are inplace computed by `f!` and `g!` respectively.
"""
function langevin(f!, g!, x, t, dt)
    μ = zero.(x)
    f!(μ, x, t)

    Σ = zero.(x)
    g!(Σ, x, t)
    W = sqrt.(Σ) .* randn(size(x)...)

    μ .* dt .+ W .* sqrt(dt)
end
