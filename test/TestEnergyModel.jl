src = "$(pwd())/src/julia"
include("$(src)/EnergyModel.jl")
include("$(src)/Utils.jl")

using Plots
using Flux
using MLDatasets: MNIST
using MLUtils: DataLoader
using ProgressMeter: @showprogress


# Data

batch = 128
trainset = MNIST(:train)

function preprocess(x)
    x = Float32.(x)
    x = 2 .*x .- 1
    # x = reshape(x, (28*28, 60000))
    x = reshape(x, (28, 28, 1, 60000))
    x
end

data = DataLoader(
    preprocess(trainset.features),
    batchsize=batch,
    shuffle=true,
)


function get_ffn(; hdims=1024)
    hdims = 1024
    Chain(
        Flux.flatten,
        Dense(dims, hdims, swish),
        Dense(hdims, hdims, swish),
        Dense(hdims, 1, bias=false),
    )
end


function get_cnn(; imgsize=(28,28,1))
    out_conv_size = (imgsize[1]÷4 - 3, imgsize[2]÷4 - 3, 16)
    
    Chain(
        Conv((5, 5), imgsize[end]=>6, relu),
        MaxPool((2, 2)),
        Conv((5, 5), 6=>16, relu),
        MaxPool((2, 2)),
        Flux.flatten,
        Dense(prod(out_conv_size), 120, relu), 
        Dense(120, 84, relu), 
        Dense(84, 1, bias=false),
    )
end


# Initialize

dims = [28, 28, 1]
network = get_cnn()
fantasy_particles = randu(Tuple(vcat(dims, [batch]))) .|> Float32
m = EnergyModel(network, fantasy_particles)
randparams = RandomWalkParams(Float32(2E-0), Float32(1E-1), Float32(2E-3))
opt = Optimise.Optimiser(
    Optimise.ClipValue(Float32(1E-1)),
    Optimise.RMSProp(Float32(1E-3)),
)


# Train

function train!(m, opt, data, randparams, log_steps)
    grad_norm_history = [Float32[] for _ in m.params]
    step = 0

    @showprogress for batch in data
        evolve!(m, randparams)
        gs = gradient(m.params) do
            loss(m, batch)
        end
        Flux.update!(opt, m.params, gs)

        if step % log_steps == 0
            for i = 1:length(gs)
                grad_norm = mean(abs.(gs[m.params[i]]))
                push!(grad_norm_history[i], grad_norm)
            end
        end

        step += 1
    end

    grad_norm_history
end

grad_norm_history = train!(m, opt, data, randparams, 5)

plot(grad_norm_history; alpha=0.5, legends=false)


# Evaluate

randparams2 = RandomWalkParams(Float32(2E+1), Float32(1E-1), Float32(0.0))
xx = collect(data)[1]
nx = xx .+ 0.2 * randn(size(xx)) .|> Float32
zz = m(nx, randparams2)

i = 1
heatmap(reshape(xx[:,:,:,i], (28, 28)))
heatmap(reshape(nx[:,:,:,i], (28, 28)))
heatmap(reshape(zz[:,:,:,i], (28, 28)))

network(nx)