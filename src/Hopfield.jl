include("Utils.jl")


mutable struct Hopfield
    U
    I
end

function activate(::Hopfield, x)
    @. tanh(x)
end


function (h::Hopfield)(x)
    f(x) = activate(h, x)
    ∇f = ∇(f)
    ∇f(x) .* (h.U * f(x) .- x .+ h.I)
end


# Test:
U = randu((1000, 1000))
U = (U' .+ U) ./ 2
I = randu(1000)
h = Hopfield(U, I)
x = randu((1000, 200))
xr = randwalk(h, x, 10.0, 0.1, 1.0)
1