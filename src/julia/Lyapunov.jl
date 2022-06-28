include("Utils.jl")

using Flux: sum, mean, params, Optimise


mutable struct Lyapunov
    E  # the parameterized function.
    θ  # the parameter.
    x  # x ~ p_D, the last axis is batch.
    x̂  # x ~ q_E, the last axis is batch.

    ∇E  # ∂E/∂x. For avoiding redundant calculation.
end


"""
Parameters
----------
E : the parameterized function.
x : the initial state of p_D.
x̂ : the initial state of q_E.

Returns
-------
Lyapunov : the Lyapunov object.
"""
function Lyapunov(E, x, x̂)
    θ = params(E)
    ∇E = ∇(E)
    Lyapunov(E, θ, x, x̂, ∇E)
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
    x = randu(datasize)
    x̂ = randu(datasize)
    Lyapunov(E, x, x̂)
end


"""
Compute ∂L/∂θ.
"""
function ∂L∂θ(E, θ, x, x̂)
    # E_{p_D}[ ∂E/∂θ ]
    ∂θpD = gradient(() -> mean(E(x)), θ)

    # E_{p_E}[ ∂E/∂θ ]
    ∂θpE = gradient(() -> mean(E(x̂)), θ)

    # ∂L/∂θ
    ∂θpD .- ∂θpE
end


"""
Compute ∂L/∂θ.
"""
function ∂L∂θ(m::Lyapunov)
    ∂L∂θ(m.E, m.θ, m.x, m.x̂)
end


"""
Implement the learning algorithm that searches for Lyapunov function.

Inplace update the `m` and the `opt`.

Parameters
----------
opt : the optimizer.
m : Lyapunov
f : the function that describes the dynamics.
t : the integration time. Emperically, t ~ 10 dt is prefered.
dt : the time step.
T : the T parameter.
resample_ratio : the ratio of resampling from Uniform(-1, 1) before simulation.
cb : the callback function. It's called after each iteration. Inputs are the
     current `m` and the gradients of `m.θ`.
"""
function update!(
    opt::Optimise.AbstractOptimiser,
    m::Lyapunov,
    f,
    t,
    dt,
    T;
    cb=nothing,
)
    # Update m.x.
    m.x .= randwalk(f, m.x, t, dt, T)

    # Update m.x̂.
    m.x̂ .= randwalk(x -> -m.∇E(x), m.x̂, t, dt, T)

    # Update m.θ.
    gs = ∂L∂θ(m)
    Optimise.update!(opt, m.θ, gs)

    if cb !== nothing
        cb(m, gs)
    end
end


"""
Compute ∇E ⋅ f for each sample.
"""
function criterion(m::Lyapunov, f, x)
    sum(m.∇E(x) .* f(x); dims=1)[1,:]
end


"""
Compute ∇E ⋅ f for each sample.
"""
function criterion(m::Lyapunov, f)
    x = randu(size(m.x))
    criterion(m, f, x)
end
