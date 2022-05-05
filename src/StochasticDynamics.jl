
"""
Define stochastic differentital equation

    dx = f(x,t) dt + g(x,t) dW, <dW, dW> = Σ(x,t) dt

Abstract Methods
----------------
- Defines the f:

        f(::AbstractSDE{T}, ::AbstractArray{T, N}, ::T)::AbstractArray{T, N}

    sde : The SDE.
    x : The state.
    t : The time.

- Deinfes the g:

        g(::AbstractSDE{T}, ::AbstractArray{T, N}, ::T, ::AbstractArray{T, M})::AbstractArray{T, N}

    sde : The SDE.
    x : The state.
    t : The time.
    dW : The Wiener process.

- Compute the dW/√dt:

        normal(::AbstractSDE{T}, ::AbstractArray{T, N}, ::T)::AbstractArray{T, M}

    sde : The SDE.
    x : The state.
    t : The time.
"""
abstract type AbstractSDE{T} end


"""
Define the solver for the SDE.

Abstract Methods
----------------
- Solve the SDE:

        solve(::AbstractSDE{T}, ::AbstractArray{T, N}, ::T, ::T; method::AbstractSolver{T})::AbstractArray{T, N}

    sde : The SDE.
    x0 : The initial state.
    t0 : The initial time.
    t1 : The final time.
    method : The method to solve the SDE.
"""
abstract type AbstractSolver{T} end


struct EulerMethod{T} <: AbstractSolver{T}
    dt::T
end


"""
Implements the Euler method of solving the SDE from t₀ to t.
"""
function solve(sde, x₀, t₀, t; method::EulerMethod{T}) where {T, N}
    x = copy(x₀)
    τ = t₀
    dτ = method.dt

    while τ < t
        dW = normal(sde, x, τ) .* √(dτ)
        x .+= f(sde, x, τ) .* dτ .+ g(sde, x, τ, dW)
        τ += dτ
    end
    x
end
