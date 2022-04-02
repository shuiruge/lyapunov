using DifferentialEquations
using Statistics: mean


function splitvh!(x::AbstractMatrix, vdim::Int)
    v = @view x[1:vdim, :]
    h = @view x[(vdim+1):end, :]
    (v, h)
end


function combinevh(v::AbstractMatrix{T}, h::AbstractMatrix{T}) where T
    cat(v, h; dims=1)
end


abstract type HopfieldNetwork{T} end


function relaxh(
        v::AbstractMatrix{T},
        h₀::AbstractMatrix{T},
        t::T;
        m::HopfieldNetwork{T},
        ) where {T<:Real}

    function f!(dh, h, _, t)
        dh .= m.U' * m.fv.(v) .- h
    end

    function g!(dh, h, _, t)
        dh .= (m.Kh.(h)).^0.5
    end

    problem = SDEProblem(f!, g!, h₀, (0.0, t))
    solution = solve(problem)
    if solution.retcode != :Success
        error("SDE solver failed")
    end
    solution.u[end]
end


function updateU!(
        m::HopfieldNetwork{T},
        v::AbstractMatrix{T},
        h::AbstractMatrix{T},
        η::T;
        λ::T,
        ) where {T<:Real}
    v_act = m.fv.(v)
    h_act = m.fh.(h)

    for i = 1:size(v, 1)
        for j = 1:size(h, 1)
            m.U[i, j] += η * (mean(v_act[i, :] .* h_act[j, :]) - λ * m.U[i, j])
        end
    end
end


function minfe!(
        m::HopfieldNetwork{T},
        v::AbstractMatrix{T},
        h₀::AbstractMatrix{T},
        t::T,
        η::T;
        λ::T,
        ) where {T<:Real}
    h = relaxh(v, h₀, t; m)
    updateU!(m, v, h, η; λ)
end


function updateI!(
        m::HopfieldNetwork{T},
        v::AbstractMatrix{T},
        ) where {T<:Real}
    m.I .= mean(m.fv.(v); dims=2)[:, 1]
end


function relaxvh(
        v₀::AbstractMatrix{A},
        h₀::AbstractMatrix{A},
        t::A;
        m::HopfieldNetwork{A},
        T::A,
        ) where {A<:Real}
    vdim = size(v₀, 1)
    
    function f!(dx, x, _, t)
        (v, h) = splitvh!(x, vdim)
        (dv, dh) = splitvh!(dx, vdim)

        dv .= m.U * m.fh.(h) .- v .+ m.I
        dh .= m.U' * m.fv.(v) .- h
    end

    function g!(dx, x, _, t)
        (v, h) = splitvh!(x, vdim)
        (dv, dh) = splitvh!(dx, vdim)

        dv .= (2T .* m.Kv.(v)).^0.5
        dh .= (2T .* m.Kh.(h)).^0.5
    end

    x₀ = combinevh(v₀, h₀)
    problem = SDEProblem(f!, g!, x₀, (0.0, t))
    solution = solve(problem)
    if solution.retcode != :Success
        error("SDE solver failed")
    end
    splitvh!(solution.u[end], vdim)
end
