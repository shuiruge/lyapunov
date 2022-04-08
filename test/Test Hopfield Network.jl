include("$(pwd())/src/HopfieldNetwork.jl")

# Configurations

vdim = 20
hdim = 10
batch = 100


mutable struct LinearHopfieldNetwork{T} <: HopfieldNetwork{T}
    U::AbstractMatrix{T}
    I::AbstractVector{T}
end

function getU!(m::LinearHopfieldNetwork)
    m.U
end

function getI!(m::LinearHopfieldNetwork)
    m.I
end

function fv(m::LinearHopfieldNetwork{T}, v::Data{T}) where T
    v
end

function fh(m::LinearHopfieldNetwork{T}, h::Data{T}) where T
    h
end

function Kv(m::LinearHopfieldNetwork{T}, v::Data{T}) where T
    v
end

function Kh(m::LinearHopfieldNetwork{T}, h::Data{T}) where T
    h
end


"""
Sample from Uniform(-1, 1).
"""
function randu(size...)
    rand(size...) .* 2 .- 1
end


# Construct an instance

v = repeat(randu(vdim), 1, batch)
U = zeros(vdim, hdim)
I = zeros(vdim)
m = LinearHopfieldNetwork(U, I)
updateI!(m, v)


# Training

# Initialize h at the stable point, where dh/dt = 0, can effectively ensure
# the numerical stability.
h = Kh(m, U' * fv(m, v))
for step = 1:10000
    minfe!(h, m; v, t=0.1, dt=0.1, η=0.1)
end


# Inference

v1 = randu(vdim, batch)
h1 = randu(hdim, batch)
(v2, h2) = relaxvh(v1, h1; m, t=1000.0, dt=0.1, T=0.0)

# Interestingly, we find that the ratios between elements of v2 and v are
# almost constant.
expect(v1) ./ expect(v)
expect(v2) ./ expect(v)

# Effect of U over I:
expect(abs.(Kv(m, U * tanh.(h1))) ./ (abs.(Kv(m, v1 .+ I)) .+ 0.1))
