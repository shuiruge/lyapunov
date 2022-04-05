include("$(pwd())/src/HopfieldNetwork.jl")

# Configurations

vdim = 20
hdim = 10
batch = 100

v = repeat(randn(vdim), 1, batch)
U = zeros(vdim, hdim)
I = getI(v)

# Training

h = randn(hdim, batch)
for step = 1:10000
    minfe!(h, U; v, warmup=(step<100), t=0.1, dt=0.1, T=0.1, η=0.1, λ=0.5)
end

# Inference

v1 = randn(vdim, batch)
h1 = randn(hdim, batch)
(v2, h2) = relaxvh(v1, h1, 100000.0, 0.1; U, I, T=0.00)

@show collect(zip(mean(v1; dims=2), mean(v; dims=2)))
@show collect(zip(mean(v2; dims=2), mean(v; dims=2)))

# Effect of U over I:
@show mean(abs.(U * tanh.(h1)) ./ (abs.(v1 .+ I) .+ 0.1); dims=2)