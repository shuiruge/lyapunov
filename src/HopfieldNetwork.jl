"""
This module implements the continuous Hopfield network discussed in the
section "Example: Continuous Hopfield Network" of the documentation.

Notations, e.g. U and I, follow the documentation.
"""

include("StochasticDynamics.jl")


mutable struct HopfieldNetwork{T}
	U::AbstractMatrix{T}
	I::AbstractVector{T}
	vdim::Int
end


function getU!(m::HopfieldNetwork)
	m.U
end


function getI!(m::HopfieldNetwork)
	m.I
end


function fv(m::HopfieldNetwork{T}, v::Data{T})
	v
end


function fh(m::HopfieldNetwork{T}, h::Data{T})
	h
end


function Kv(m::HopfieldNetwork{T}, v::Data{T})
end


function Kh(m::HopfieldNetwork{T}, h::Data{T})
end


function splitvh!(x::Data, vdim::Int)
	v = @view x[1:vdim, :]
	h = @view x[(vdim+1):end, :]
	(v, h)
end


function combinevh(v::Data{T}, h::Data{T}) where T
	cat(v, h; dims=1)
end


function constant(c, size)
	c .* ones(size...)
end


function langevin(m::HopfieldNetwork)
	Langevin()
end


# ---------------------------------------------


function relaxh!(
	h::Data{A};
	m::HopfieldNetwork{A},
	v::Data{A},
	t::A,
	dt::A,
	T::A,
) where {A<:Real}
	U = getU!(m)

	function f!(μ, h, t)
		μ .= Kh(m, U' * fv(m, v) .- h)
	end

	function g!(Σ, h, t)
		Σ .= Kh(m, constant(2T, size(h)))
	end

	h .= langevin(f!, g!, h, t, dt)
end


"""
The Hebbian rule.
"""
function updateU!(
	m::HopfieldNetwork{T};
	v::Data{T},
	h::Data{T},
	η::T,
	λ::T,
	max_gradient_abs::T,
) where {T<:Real}
	vdim = size(v, 1)
	hdim = size(h, 1)

	actv = fv(m, v)
	acth = fh(m, h)

	# Compute -∂E/∂U, as `grad`.
	grad = zeros(vdim, hdim)
	for i = 1:vdim
		for j = 1:hdim
			grad[i, j] = mean(actv[i, :] .* acth[j, :])
			if abs(grad[i, j]) > max_gradient_abs
				return
			end
		end
	end

	U = getU!(m)
	U .+= η .* (grad - λ .* U)
end


"""
Implements the RL algorithm for one step iteration.
	
This algorithm minimizes the free energy, thus is named as `min-f-e`.

Parameters
----------
- h : The initial value of the latent variables.
- m : The Hopfield network.
- v : The ambient variables.
- t : The integral time.
- dt : The time step.
- η : The learning rate.
- T : The factor that balances the expected energy and entropy.
- λ : The regularization parameter.
- warmup : Is a warmup step.
- max_gradient_abs : The maximum absolute value of the gradient.
"""
function minfe!(
    h::Data{A},
    m::HopfieldNetwork{A};
    v::Data{A},
    t::A,
    dt::A,
    η::A,
    T::A = 1.0,
    λ::A = 0.0,
    warmup::Bool = false,
	max_gradient_abs::A = 1E+2,
) where {A<:Real}
    relaxh!(h; m, v, t, dt, T)
    if warmup == false
        updateU!(m; v, h, η, λ, max_gradient_abs)
    end
end


function relaxvh(
	v::Data{A},
	h::Data{A};
	m::HopfieldNetwork{A},
	t::A,
	dt::A,
	T::A,
) where {A<:Real}
	vdim = size(v, 1)
	U = getU!(m)

	function f!(μ, x, t)
		(μv, μh) = splitvh!(μ, vdim)
		(v, h) = splitvh!(x, vdim)

		μv .= Kv(m, U * fh(m, h) .- v .+ I)
		μh .= Kh(m, U' * fv(m, v) .- h)
	end

	function g!(Σ, x, t)
		(v, h) = splitvh!(x, vdim)
		Σ .= combinevh(
			Kv(m, constant(2T, size(v))),
			Kh(m, constant(2T, size(h))))
	end

	x = combinevh(v, h)
	x = langevin(f!, g!, x, t, dt)
	splitvh!(x, vdim)
end


function updateI!(
	m::HopfieldNetwork{T},
	v::Data{T}
) where {T<:Real}
	I = getI!(m)
	I .= expect(fv(m, v))
end
