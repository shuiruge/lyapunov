
"""
Define stochastic differentital equation

    dx = f(x,t) dt + g(x,t) dW, <dW, dW> = Σ(x,t) dt

Methods
-------
f : function of x and t
g : function of x and t
normal : sample from Normal(0, Σ(x,t))
"""
abstract type SDE{T} end

"""
The f(x,t) function in the SDE.

Parameters
----------
sde : The SDE.
x : The state.
t : The time.
"""
function f(::SDE{T}, ::AbstractArray{T, N}, ::T)::AbstractArray{T, N} where {T, N} end

"""
The g(x,t) function in the SDE.

Parameters
----------
sde : The SDE.
x : The state.
t : The time.
dW : The Wiener process.
"""
function g(::SDE{T}, ::AbstractArray{T, N}, ::T, ::AbstractArray{T, M})::AbstractArray{T, N} where {T, M, N} end

"""
Compute the dW/√dt.

Parameters
----------
sde : The SDE.
x : The state.
t : The time.
"""
function normal(::SDE{T}, ::AbstractArray{T, N}, ::T)::AbstractArray{T, M} where {T, M, N} end


"""
Define the solver for the SDE.

Methods
-------
solve : Solve the SDE.
"""
abstract type Solver{T} end
function solve(::SDE{T}, ::AbstractArray{T, N}, ::T, ::T; method::Solver{T})::AbstractArray{T, N} where {T, N} end


struct EulerMethod{T} <: Solver{T}
    dt::T
end


"""
Implements the Euler method of solving the stochastic dynamics during [0, t].
"""
function solve(sde, x₀, t₀, t; method::EulerMethod{T}) where {T, N}
    x = copy(x₀)
    τ = t₀
    dτ = method.dt

    while τ < t
        r = normal(sde, x, τ)
        x .+= f(sde, x, τ) * dτ + g(sde, x, τ, r) * √(dτ)
        τ += dτ
    end
    x
end
