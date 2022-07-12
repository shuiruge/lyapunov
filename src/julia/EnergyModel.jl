include("Utils.jl")

using Flux: sum, mean, params, Optimise, Chain, gradient


mutable struct EnergyModel
    network
    params
    fantasy_particles
end


function get_vector_field(m::EnergyModel)
    function vector_field(x, t)
        # Since the network is -E, then -∇E is the gradient of the network.
        gradient(sum ∘ m.network, x)[1]
    end
    vector_field
end


function EnergyModel(network, fantasy_particles)
    EnergyModel(network, params(network), fantasy_particles)
end


function (m::EnergyModel)(real_particles, params)
    x = copy(real_particles)
    random_walk(get_vector_field(m), x, params)
end


function evolve!(m::EnergyModel, params)
    m.fantasy_particles .= m(m.fantasy_particles, params)
end


function loss(m::EnergyModel, real_particles)
    # Since the network is -E, then the position of real and fantasy particles
    # are reversed.
    mean(m.network(m.fantasy_particles)) - mean(m.network(real_particles))
end
