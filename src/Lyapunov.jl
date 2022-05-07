using Flux


"""
Compute x + dx, where

    dx = f(x) dt + √(2T) dW, dW ~ Normal(0, δ dt).

"""
function simulate(x, f, dt, T)
    dW = randn(size(x)) * sqrt(dt)
    dx = f(x) * dt .+ sqrt(2T) * dW
    x .+ dx
end


"""
Returns the function ∇f, where

  - if it's f(x), then return ∂f/∂x; and
  - if it's f(x, y, ...), then return (∂f/∂x, ∂f/∂y, ...).

"""
function ∇(f)

    function ∇f(args...)
        if length(args) == 1
            # If it's f(x), then return ∂f/∂x
            gradient(Flux.sum ∘ f, args...)[1]
        else
            # If it's f(x, y, ...), then return (∂f/∂x, ∂f/∂y, ...)
            gradient(Flux.sum ∘ f, args...)
        end
    end

    ∇f
end


"""
Random sample from Uniform(-1, 1).
"""
function randu(size)
    2 * rand(Float64, size) .- 1
end


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
    m.xD .= simulate(m.xD, f, dt, T)

    # Update m.xE.
    ∇E = ∇(m.E)
    m.xE .= simulate(m.xE, x -> -∇E(x), dt, T)

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


"""
Computes the MCMC chains. The nested dimensions, if any, are flatten,
so that the returned `chains`, as an array, has shape:

    (iterations, total_dimensions, number_of_chains)


Parameters
----------
- f
- x: Initial samples. 
- t: Integration time.
- dt
- T

Returns
-------
- chains: The input of `MCMCDiagnosticTools.gelmandiag_multivariate`.
- x: Final samples.
"""
function getchains(f, x, t, dt, T)
    function flatten_dims(x)
        batch = size(x)[end]
        dims = prod(size(x)[1:end-1])
        reshape(x, (1, dims, batch))
    end

    # Initialize.
    x = copy(x)
    chains = flatten_dims(x)
    τ = zero(t)

    while τ < t
        x .= simulate(x, f, dt, T)
        chains = cat(chains, flatten_dims(x); dims=1)
        τ += dt
    end

    chains, x
end
