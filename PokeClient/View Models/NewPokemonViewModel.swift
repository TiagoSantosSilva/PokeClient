//
//  NewPokemonViewModel.swift
//  PokeClient
//
//  Created by Tiago Santos on 27/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

class NewPokemonViewModel {
    
    internal var dataManager: DataManager!
    
    init() {
        dataManager = DataManager(baseUrl: API.BaseUrl)
    }
}

// MARK: - Data Handling
extension NewPokemonViewModel {
    private func getRequestEndpointAndMethod(pokemonToSendId: Int?) -> (String, String) {
        guard let pokemonId = pokemonToSendId else {
            return (endpoint: API.PokemonsEndpoint, method: "POST")
        }
        return (endpoint: "\(API.PokemonsEndpoint)/\(String(describing: pokemonId))", method: "PUT")
    }
    
    func performRequest(pokemon: Pokemon, _ completion: @escaping PokemonCompletion) {
        
        let encodedPokemon = try? JSONEncoder().encode(pokemon) as Data
        guard let data = encodedPokemon else { return }
        
        let requestTuple = getRequestEndpointAndMethod(pokemonToSendId: pokemon.id)
        let requestEndpoint = requestTuple.0
        let requestMethod = requestTuple.1
        
        sendPokemonRequest(forRequestEndpoint: requestEndpoint, data: data, andRequestMethod: requestMethod) { (pokemon) in
            guard pokemon != nil else {
                completion(nil)
                return
            }
            
            completion(pokemon)
        }
    }
}

// MARK: - Requests
extension NewPokemonViewModel {
    private func sendPokemonRequest(forRequestEndpoint requestEndpoint: String, data: Data, andRequestMethod requestMethod: String, _ completion: @escaping PokemonCompletion) {
        dataManager.postData(endpoint: requestEndpoint, data: data, method: requestMethod, Pokemon.self) { (result, error) in
            guard let pokemon = result as? Pokemon else {
                // TODO: Present Alert Controller
                completion(nil)
                return
            }
            completion(pokemon)
        }
    }
}
