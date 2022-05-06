include("$(pwd())/src/Lyapunov.jl")
using Plots


"""
Split the array along the axis.
"""
function split!(array, axis)
    [selectdim(array, axis, i) for i in 1:size(array, axis)]
end


function vanilla_test(x)
    dx = zero.(x)  # initialize.

    (dx₁, dx₂) = split!(dx, 1)
    (x₁, x₂) = split!(x, 1)

    @. dx₁ = -x₁
    @. dx₂ = -x₂

    dx
end


function damped_pendulum(x)
    dx = zero.(x)  # initialize.

    (dx₁, dx₂) = split!(dx, 1)
    (x₁, x₂) = split!(x, 1)

    @. dx₁ = tanh(x₂)
    @. dx₂ = -sin(tanh(x₁)) - tanh(x₂)

    dx
end



function damped_oscillator(x)
    dx = zero.(x)  # initialize.

    (dx₁, dx₂) = split!(dx, 1)
    (x₁, x₂) = split!(x, 1)

    # Let x₁ the position of an oscillator, and x₂ the velocity.
    @. dx₁ = x₂
    @. dx₂ = -0.2 * x₁ - x₂

    dx
end


# Initialize

f = damped_oscillator
E = Chain(Dense(2, 256, relu), Dense(256, 1, bias=false))
batch = 128
m = Lyapunov(E, (2, batch))
opt = Flux.Optimise.RMSProp(1E-3)
dt = 1E-1
T = 1E-2
train_steps = 20000
warmup_steps = 1000

xc = copy(m.xD)
histogram(criterion(m, f, xc), bins=100)


# Training

grad_norm_history = [Float64[] for _ in m.θ]
function history_callback(m, gs)
    global grad_norm_history
    for i = 1:length(gs)
        grad_norm = Flux.mean(abs.(gs[m.θ[i]]))
        push!(grad_norm_history[i], grad_norm)
    end
end

for step = 1:train_steps
    warmup = step < warmup_steps
    update!(m, f, dt, T, warmup, opt; cb=history_callback)
end


# Results

plot(grad_norm_history; alpha=0.5)
histogram(criterion(m, f, xc), bins=100)
histogram(criterion(m, f, m.xD), bins=100)


# TODO: MCMC Convergence

using MCMCDiagnosticTools

x = randu((2, batch))
for i = 1:10
    chains, x = getchains(f, x, 2E+2, dt, T)
    psrfmultivariate = gelmandiag_multivariate(chains).psrfmultivariate
    @show i, psrfmultivariate
end
