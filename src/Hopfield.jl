include("Utils.jl")


mutable struct Hopfield{T}
    U::AbstractMatrix{T}
    I::AbstractVector{T}
end


function activate(::Hopfield{T}, x::AbstractArray{T}) where {T<:Real}
    @. tanh(x)
end


function (h::Hopfield{T})(x::AbstractArray{T}) where {T<:Real}
    f(x) = activate(h, x)
    ∇f = ∇(f)
    ∇f(x) .* (h.U * f(x) .- x .+ h.I)
end


# Test:
h = Hopfield(randu((10, 10)), randu(10))
x = randu((10, 100))
h(x)