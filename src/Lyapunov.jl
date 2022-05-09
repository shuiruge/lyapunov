include("Utils.jl")

using Flux


mutable struct Lyapunov
    E  # the parameterized function
    θ  # the parameter
    xD  # x ~ p_D, the last axis is batch.
    xE  # x ~ q_E, the last axis is batch.
end


"""
Parameters
----------
E : the parameterized function.
xD : the initial state of p_D.
xE : the initial state of q_E.

Returns
-------
Lyapunov : the Lyapunov object.
"""
function Lyapunov(E, xD, xE)
    θ = Flux.params(E)
    Lyapunov(E, θ, xD, xE)
end


"""
Parameters
----------
E : the parameterized function.
datasize : the last axis is batch.

Returns
-------
Lyapunov : the Lyapunov object.
"""
function Lyapunov(E, datasize)
    xD = randu(datasize)
    xE = randu(datasize)
    Lyapunov(E, xD, xE)
end


"""
Compute ∂L/∂θ.
"""
function ∂L∂θ(E, θ, xD, xE)
    # E_{p_D}[ ∂E/∂θ ]
    ∂θpD = gradient(() -> Flux.mean(E(xD)), θ)

    # E_{p_E}[ ∂E/∂θ ]
    ∂θpE = gradient(() -> Flux.mean(E(xE)), θ)

    # ∂L/∂θ
    ∂θpD .- ∂θpE
end


"""
Compute ∂L/∂θ.
"""
function ∂L∂θ(m::Lyapunov)
    ∂L∂θ(m.E, m.θ, m.xD, m.xE)
end


"""
Implement the learning algorithm that searches for Lyapunov function.

Inplace update the `m` and the `opt`.

Parameters
----------
m : Lyapunov
f : the function that describes the dynamics.
dt : the time step.
T : the T parameter.
warmup : if it's a warmup step.
opt : the optimizer.
cb : the callback function. It's called after each iteration. Inputs are the
     current `m` and the gradients of `m.θ`.
"""
function update!(
    m::Lyapunov,
    f,
    dt,
    T,
    warmup::Bool,
    opt::Flux.Optimise.AbstractOptimiser;
    cb=nothing,
)
    # Update m.xD.
    m.xD .= randwalk(f, m.xD, dt, T)

    # Update m.xE.
    ∇E = ∇(m.E)
    m.xE .= randwalk(x -> -∇E(x), m.xE, dt, T)

    # If not a warmup step, then update m.θ.
    if warmup == false
        gs = ∂L∂θ(m)
        Flux.Optimise.update!(opt, m.θ, gs)

        if cb !== nothing
            cb(m, gs)
        end
    end
end


"""
Compute ∇E ⋅ f for each sample.
"""
function criterion(m::Lyapunov, f, x)
    ∇E = ∇(m.E)
    Flux.sum(∇E(x) .* f(x); dims=1)[1,:]
end
