src = "$(pwd())/src/julia"
include("$(src)/Lyapunov.jl")
include("$(src)/Utils.jl")

using Plots
using Flux: mean, Optimise
using ProgressMeter: @showprogress
using LinearAlgebra: eigvals


"""
Vanilla test dynamics.

Returns
-------
f : the vector field function.
dims : the phase space dimensions.
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
τ : the time scale.
μ : the damping coefficient.
k : the spring constant.

Returns
-------
f : the vector field function.
dims : the phase space dimensions.
"""
function damped_oscillator(τ, μ, k)
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
        @. dx₁ = x₂ / τ
        @. dx₂ = (-k * x₁ - μ * x₂) / τ

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
τ : the time scale.
μ : the damping coefficient.
kmin : the minimum of spring constant.
kmax : the maximum of spring constant.

Returns
-------
f : the vector field function.
dims : the phase space dimensions.
"""
function param_damped_oscillator(τ, μ, kmin, kmax)

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
        @. dx₁ = x₂ / τ
        @. dx₂ = (-k(z) * x₁ - μ * x₂) / τ
        @. dz = 0

        dx
    end

    f!, 3
end


function linear(A)
    @show eigvals(A)
    x -> A*x, size(A, 1)
end


# Initialize

# f, dims = damped_oscillator(1.0, 1.0, 0.5)
f, dims = param_damped_oscillator(1.0, 1.0, 0.1, 0.5)
# A = randu((2, 2)); f, dims = linear(A)
hdims = 128
E = Chain(
    Dense(dims, hdims, relu),
    Dense(hdims, 1, bias=false),
)
batch = 128
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
histogram(criterion(m, f), bins=100, title="Initial Criterion", legends=false)


# Markov Chain Convergence

anim = animate_dist(f, randu((dims, batch)), dt, 1E-2, 100, 100; xlims=(-2.0, 2.0))
gif(anim, fps=3)


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
    cb = (step % 100 == 0) ? history_callback : nothing
    update!(opt, m, f, t, dt, T; cb=cb)
end


# Results

plot(grad_norm_history; alpha=0.5, legends=false)

xc = randu(size(m.x))
histogram(criterion(m, f, xc), bins=100, title="Final Criterion", legends=false)
max(criterion(m, f, xc)...)
max(criterion(m, f, m.x)...)
max(criterion(m, f, m.x̂)...)

norm(x) = maximum(abs, x, dims=1)[1, :]
histogram(norm(f(xc)) ./ (norm(m.∇E(xc)) .+ 1E-10), bins=100, title="|f(x)| / (|∇E(x)| + ϵ)", legends=false)
histogram(norm(m.∇E(xc)) ./ (norm(f(xc)) .+ 1E-10), bins=100, title="|∇E(x)| / (|f(x)| + ϵ)", legends=false)

histogram(criterion(m, f, m.x), bins=100, title="Criterion on pD")
histogram(criterion(m, f, m.x̂), bins=100, title="Criterion on pE")
