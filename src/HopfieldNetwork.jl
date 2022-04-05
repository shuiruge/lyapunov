using Statistics: mean

Data{T} = AbstractMatrix{T}


function splitvh!(x::Data, vdim::Int)
	v = @view x[1:vdim, :]
	h = @view x[(vdim+1):end, :]
	(v, h)
end


function combinevh(v::Data{T}, h::Data{T}) where T
	cat(v, h; dims=1)
end


"""
Implements the langevin dynamics algorithm.
"""
function langevin(f!, g!, x, t, dt)
    μ = zero.(x)
    f!(μ, x, t)

    Σ = zero.(x)
    g!(Σ, x, t)
    W = sqrt.(Σ) .* randn(size(x)...)

    μ .* dt .+ W .* sqrt(dt)
end


function relaxh!(
	h::Data{A};
	U::AbstractMatrix{A},
	v::Data{A},
	t::A,
	dt::A,
	T::A,
) where {A<:Real}

	function f!(μ, h, t)
		μ .= U' * tanh.(v) .- h
	end

	function g!(Σ, h, t)
		# Notice d^2 L_h = tanh'(h) = 1 - tanh(h)^2
		Σ .= @. 2T / (1 - (tanh(h))^2)

        # TODO: Caution that there's numerical instability here.
        #       It comes from large h, where tanh(h) is close to 1,
        #       leading to large Σ.

	end

	h .= langevin(f!, g!, h, t, dt)
end


function updateU!(
	U::AbstractMatrix{T};
	v::Data{T},
	h::Data{T},
	η::T,
	λ::T,
) where {T<:Real}

	actv = tanh.(v)
	acth = tanh.(h)

	for i = 1:size(v, 1)
		for j = 1:size(h, 1)
			grad_U = mean(actv[i, :] .* acth[j, :])
			U[i, j] += η * (grad_U - λ * U[i, j])
		end
	end
end


"""
Implements the minimize free energy process.

- `h` is the hidden state.
- `U` is the weight matrix.
- `v` is the visible state.
- `warmup` is a boolean flag indicating whether to warm up the process.
- `t` is the integration time.
- `dt` is the integration time step.
- `T` is the "temperature".
- `η` is the learning rate.
- `λ` is the weight decay.
"""
function minfe!(
    h::Data{A},
    U::AbstractMatrix{A};
    v::Data{A},
    warmup::Bool,
    t::A,
    dt::A,
    T::A,
    η::A,
    λ::A,
) where {A<:Real}
    relaxh!(h; U, v, t, dt, T)
    if warmup == false
        updateU!(U; v, h, η, λ)
    end
end


function relaxvh(
	v::Data{A},
	h::Data{A},
	t::A,
	dt::A;
	U::AbstractMatrix{A},
	I::AbstractVector{A},
	T::A,
) where {A<:Real}
	vdim = size(v, 1)

	function f!(μ, x, t)
		(μv, μh) = splitvh!(μ, vdim)
		(v, h) = splitvh!(x, vdim)

		μv .= U * tanh.(h) .- v .+ I
		μh .= U' * tanh.(v) .- h
	end

	function g!(Σ, x, t)
		# Notice d^2 L_v = tanh'(v) = 1-tanh(v)^2.
		# And the same for v. Thus the whole x.
		Σ .= @. 2T / (1 - (tanh(x))^2)
	end

	x = combinevh(v, h)
	x = langevin(f!, g!, x, t, dt)
	splitvh!(x, vdim)
end


function getI(v::Data{T}) where {T<:Real}
	mean(tanh.(v); dims=2)[:, 1]
end
