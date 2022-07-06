src = "$(pwd())/src/julia"
include("$(src)/Lyapunov.jl")
include("$(src)/Utils.jl")

using Plots
using Flux
using MLDatasets: MNIST
using MLUtils: DataLoader
using ProgressMeter: @showprogress


# Data

batch = 128
trainset = MNIST(:train)
X = DataLoader(
    reshape(trainset.features, (28*28, 60000)),
    batchsize=batch,
    shuffle=true,
)


# Initialize

dims = 28*28
hdims = 1024
E = Chain(
    Dense(dims, hdims, relu),
    Dense(hdims, 1, bias=false),
)
m0 = Lyapunov(E, (dims, batch))
dt = 1E-1
t = 12dt
T = 1E-2
train_steps = 100000
# Optimise.ADAM is utterly unstable, should be avoided.
opt0 = Optimise.Optimiser(
    Optimise.ClipValue(1E-1),
    Optimise.RMSProp(1E-3),
)

m = deepcopy(m0)
opt = deepcopy(opt0)


# Train

grad_norm_history = [Float64[] for _ in m.θ]
function history_callback(m, gs)
    global grad_norm_history
    for i = 1:length(gs)
        grad_norm = mean(abs.(gs[m.θ[i]]))
        push!(grad_norm_history[i], grad_norm)
    end
end

@showprogress for (step, x) in enumerate(X)
    if size(x, 2) != batch
        continue
    end
    cb = (step % 20 == 0) ? history_callback : nothing
    update_with_data!(opt, m, x, t, dt, T; cb=cb)
end

plot(grad_norm_history; alpha=0.5, legends=false)


# Evaluate

xx = collect(X)[1]
nx = xx .+ 0.5 * randn(size(xx))
zz = randwalk(x -> -m.∇E(x), nx, 3t, dt, 0.0)

i = 1
heatmap(reshape(xx[:, i], (28, 28)))
heatmap(reshape(nx[:, i], (28, 28)))
heatmap(reshape(zz[:, i], (28, 28)))