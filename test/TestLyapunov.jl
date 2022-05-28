src = "$(pwd())/src"
include("$(src)/Lyapunov.jl")
include("$(src)/Utils.jl")

using Plots
using Flux: mean, Optimise
using MCMCDiagnosticTools: gelmandiag_multivariate
using ProgressMeter: @showprogress



"""
Vanilla test dynamics.

Returns
-------
f : the vector field function.
dim : the phase space dimension.
"""
function vanilla()

    function f(x)
        dx = zero.(x)  # initialize.

        (dx₁, dx₂) = split!(dx, 1)
        (x₁, x₂) = split!(x, 1)

        @. dx₁ = -x₁
        @. dx₂ = -x₂

        dx
    end

    f, 2
end


"""
Damped oscillator.

Parameters
----------
k : the spring constant.
μ : the damping coefficient.

Returns
-------
f : the vector field function.
dim : the phase space dimension.
"""
function damped_oscillator(k, μ)
    # Determine the criticality of the damped oscillator.
    criticality = μ^2 - 4 * k
    if criticality > 0
        println("Overdamped oscillator.")
    elseif criticality < 0
        println("Underdamped oscillator.")
    else
        println("Critical damping oscillator.")
    end

    function f(x)
        dx = zero.(x)  # initialize.

        (dx₁, dx₂) = split!(dx, 1)
        (x₁, x₂) = split!(x, 1)

        # Let x₁ the position of an oscillator, and x₂ the velocity.
        @. dx₁ = x₂
        @. dx₂ = -k * x₁ - μ * x₂

        dx
    end

    f, 2
end


"""
Damped oscillator with a free stiffness factor between kmin and kmax.

Remark:
    Using period linear function for k furnishes a much better results than
    non-linear function, e.g. sigmoid function.

Parameters
----------
kmin : the minimum of spring constant.
kmax : the maximum of spring constant.
μ : the damping coefficient.

Returns
-------
f : the vector field function.
dim : the phase space dimension.
"""
function param_damped_oscillator(kmin, kmax, μ)

    function period_linear(x)
        if 0 <= x <= 1
            x
        elseif 1 < x <= 2
            2 - x
        elseif x < 0
            period_linear(x + 2)
        else  # x > 2
            period_linear(x - 2)
        end
    end

    function k(z)
        (kmax - kmin) * period_linear(z) + kmin
    end

    function f(x)
        dx = zero.(x)  # initialize.

        (dx₁, dx₂, dz) = split!(dx, 1)
        (x₁, x₂, z) = split!(x, 1)

        # Let x₁ the position of an oscillator, and x₂ the velocity.
        @. dx₁ = x₂
        @. dx₂ = -k(z) * x₁ - μ * x₂
        @. dz = 0

        dx
    end

    f, 3
end


# Initialize

# f, dim = damped_oscillator(0.5, 1.0)
f, dim = param_damped_oscillator(0.1, 0.5, 1.0)
hdim = 512
E = Chain(
    Dense(dim, hdim, relu),
    Dense(hdim, 1, bias=false),
)
batch = 128
m = Lyapunov(E, (dim, batch))
dt = 1E-1
T = 1E-2
train_steps = 100000
# Optimise.ADAM is utterly unstable, should be avoided.
opt = Optimise.Optimiser(
    Optimise.ClipValue(1E-1),
    Optimise.RMSProp(1E-3),
)

histogram(criterion(m, f), bins=100, title="Initial Criterion")


# MCMC Convergence

t = 10.
x = randu((dim, batch))
full_chains = Float64[]
rs = Float64[]
for i = 1:100
    global x, full_chains, rs
    chains, x = getchains(f, x, t, dt, T)
    full_chains = cat(full_chains, chains; dims=1)
    push!(rs, gelmandiag_multivariate(full_chains).psrfmultivariate)
end
plot(rs, title="MCMC Convergence", ylims=(0, max(rs...)))


# Training

grad_norm_history = [Float64[] for _ in m.θ]
function history_callback(m, gs)
    global grad_norm_history
    for i = 1:length(gs)
        grad_norm = mean(abs.(gs[m.θ[i]]))
        push!(grad_norm_history[i], grad_norm)
    end
end

@showprogress for step = 1:train_steps
    cb = (step % 20 == 0) ? history_callback : nothing
    update!(opt, m, f, dt, T; cb=cb)
end


# Results

plot(grad_norm_history; alpha=0.5)
histogram(criterion(m, f), bins=100, title="Final Criterion")

histogram(criterion(m, f, m.x), bins=100, title="Criterion on Samples")
