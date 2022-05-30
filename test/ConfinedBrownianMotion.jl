using Statistics: var
using Plots


"""
Computes the variance of the confined Brownian motion with boundary (-1, 1).

Parameters
----------
x : the initial position.
dt : the time step.
n : the number of samples.

Returns
-------
variance : the variance of the δx, divided by dt.
"""
function simulate_variance(x, dt, n)

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

    var(z) / dt
end


dt = 1E-1
n = 2^12
x = Float64[]
y = Float64[]
for xi = -0.99:0.002:0.99
    push!(x, xi)
    push!(y, simulate_variance(xi, dt, n))
end
plot(x, y)
