include("./StochasticDynamics.jl")
using Random


struct LyaSDE{A} <: AbstractSDE{A}
    f;
    T::A;
end


function f(sde::LyaSDE, x, t)
    sde.f(x)
end


function g(sde::LyaSDE, x, t, dW)
    √(2*sde.T) .* dW
end


function normal(sde::LyaSDE, x, t)
    randn(size(x)...)
end


function simulate(f, x, dt, T)
    sde = LyaSDE(f, T)
    solve(sde, x, zero(dt), dt; method=EulerMethod(dt))
end
