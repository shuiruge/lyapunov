using Flux


"""
Compute x + dx, where

    dx = f(x) dt + √(2T) dW, dW ~ Normal(0, δ dt).

"""
function randwalk(f, x, dt, T)
    dW = randn(size(x)) * sqrt(dt)
    dx = f(x) * dt .+ sqrt(2T) * dW
    x .+ dx
end


function randwalk(f, x, t, dt, T)
    τ = zero(t)
    while τ < t
        x = randwalk(f, x, dt, T)
        τ += dt
    end
    x
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
        x .= randwalk(f, x, dt, T)
        chains = cat(chains, flatten_dims(x); dims=1)
        τ += dt
    end

    chains, x
end


"""
Split the array along the axis.
"""
function split!(array, axis)
    [selectdim(array, axis, i) for i in 1:size(array, axis)]
end


"""
f(0) = 0, f'(0₋) = -1, f'(0₊) = 1. min(f) = 0, max(f) =  1, and period 2.
"""
function period_linear(x)
    if 0 <= x <= 1
        x
    elseif 1 < x <= 2
        2 - x
    elseif x < 0
        period_linear(x + 2)
    else  # x > 2
        period_linear(x - 2)
    end
end


function flatten(x)
    shape = prod(size(x))
    reshape(x, shape)
end
