using Statistics: mean


const Datum{T} = AbstractVector{T}


"""
The data has the size (dimension, batch).
"""
const Data{T} = AbstractMatrix{T}


function expect(x::Data{T})::AbstractVector{T} where T
	mean(x; dims=2)[:, 1]
end
