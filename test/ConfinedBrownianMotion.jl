using Statistics: mean, var
using Plots


"""
Computes the mean and variance of the confined Brownian motion with boundary
(-1, 1).

Parameters
----------
x : the initial position.
dt : the time step.
n : the number of samples.

Returns
-------
mean : the mean of the δx, divided by dt.
variance : the variance of the δx, divided by dt.
"""
function simulate(x, dt, n)

    # Continuously re-map the z to the range [-1, 1].
    function remap(z)
        if z < -1
            z = -z - 2
        elseif z > 1
            z = -z + 2
        else
            z
        end
    end

    z = x .+ randn((n,)) * sqrt(dt)
    @. z = remap(z)

    δx = z .- x
    mean(δx), var(δx)
end


dt = 1E-2
n = 2^12
x = Float64[]
means = Float64[]
vars = Float64[]
for xi = -0.99:0.002:0.99
    push!(x, xi)
    (mean_, var_) = simulate(xi, dt, n)
    push!(means, mean_)
    push!(vars, var_/dt)
end

plot(x, means, title="mean")
plot(x, vars, title="variance / dt")
