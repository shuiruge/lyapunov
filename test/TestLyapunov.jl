include("$(pwd())/src/Lyapunov.jl")


function f(x)
    dx = zero.(x)
    dx[1] = x[2]
    dx[2] = -sin(x[1]) - x[2]
    dx
end

@show simulate(f, [1. 0.; 2. .1], 0.1, 1.)
