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

The stiffness factor is induced by a dynamical variables which runs on a
circular boundary, such that the value of it always ranges from -1 to 1.
This setting is for ensuring the convergence of the induced Markov chain.

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

    # Continuously re-map the z to the range [-1, 1].
    function remap(z)
        if z < -1
            z = -z - 2
        elseif z > 1
            z = -z + 2
        else
            z
        end
    end

    function k(z)
        (kmax - kmin) * (z + 1) / 2 + kmin
    end

    # Will inplace re-map the z to the range [-1, 1].
    function f!(x)
        dx = zero.(x)  # initialize.

        (dx₁, dx₂, dz) = split!(dx, 1)
        (x₁, x₂, z) = split!(x, 1)

        @. z = remap(z)

        # Let x₁ the position of an oscillator, and x₂ the velocity.
        @. dx₁ = x₂
        @. dx₂ = -k(z) * x₁ - μ * x₂
        @. dz = 0

        dx
    end

    f!, 3
end


# Initialize

# f, dim = damped_oscillator(0.5, 1.0)
f, dim = param_damped_oscillator(0.1, 0.5, 1.0)
hdim = 128
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
@showprogress for i = 1:100
    global x, full_chains, rs
    chains, x = getchains(f, x, t, dt, T)
    full_chains = cat(full_chains, chains; dims=1)
    push!(rs, gelmandiag_multivariate(full_chains).psrfmultivariate)
end
plot(rs, title="MCMC Convergence", ylims=(1, max(rs...)))


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

xc = randu(size(m.x))
histogram(criterion(m, f, xc), bins=100, title="Final Criterion")

norm(x) = mean(abs.(x), dims=1)[1, :]
histogram(norm(f(xc)) ./ (norm(m.∇E(xc)) .+ 1E-10), bins=100, title="|f(x)| / (|∇E(x)| + ϵ)")
histogram(norm(m.∇E(xc)) ./ (norm(f(xc)) .+ 1E-10), bins=100, title="|∇E(x)| / (|f(x)| + ϵ)")

histogram(criterion(m, f, m.x), bins=100, title="Criterion on Samples")
