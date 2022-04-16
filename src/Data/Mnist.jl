include("../Utils.jl")

using ImageTransformations


function preprocess(X, imgsize)
    X = imresize(X, imgsize)
    X = reshape(X, imgsize[1] * imgsize[2], size(X, 3))
end


"""
Randomly flip `bits` bits on the binary datum `binary`.
"""
function addnoise(binary::Datum, bits::Integer)
    indices = 1:size(binary, 1)
    random_indices = rand(indices, bits)

    function flip(index)
        if (index ∈ random_indices)
            1 - binary[index]
        else
            binary[index]
        end
    end

    map(flip, indices)
end


function filter_by_labels(X::AbstractArray{3}, y::AbstractVector, labels::AbstractVector)
    indices = filter(i -> y[i] ∈ labels, 1:size(y, 1))
    X̃ = cat([X[:, :, i] for i in indices]...; dims=3)
    ỹ = [y[i] for i in indices]
    X̃, ỹ, indices
end


function onehot(x::T, labels::AbstractVector{T}) where T
    [(labels[i] == x) ? one(x) : zero(x) for i = 1:size(labels, 1)]
end


"""
CAUTION: this function is quite slow.
"""
function onehot(x::AbstractVector{T}, labels::AbstractVector{T}) where T
    cat([onehot(x[i], labels) for i = 1:size(x, 1)]...; dims=2)
end


function showimage(image::AbstractMatrix{T}) where T<:Real
    for i = 1:size(image, 1)
        for j = 1:size(image, 2)
            if image[i, j] < 0.5
                print(" ")
            else
                print("X")
            end
        end
        print("\n")
    end
end
