//
//  PokemonDetailsViewModel.swift
//  PokeClient
//
//  Created by Tiago Santos on 28/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

class PokemonDetailsViewModel {
    
    private var pokemonDetailsViewController: PokemonDetailsViewController!
    private var pokemonListViewController: PokemonListViewController!
    var pokemon: Pokemon!
    private var pokemonId: Int!
    
    internal var dataManager: DataManager!
    internal var apiClient: ApiClient!
    
    init(pokemonId: Int, pokemonDetailsViewController: PokemonDetailsViewController, pokemonListViewController: PokemonListViewController) {
        self.pokemonId = pokemonId
        self.pokemonDetailsViewController = pokemonDetailsViewController
        self.pokemonListViewController = pokemonListViewController
        self.dataManager = DataManager(baseUrl: API.BaseUrl)
        self.apiClient = ApiClient(baseUrl: API.SerebiiImageUrl)
    }
    
    func getPokemonById(completion: @escaping PokemonCompletion) {
        guard let pokemonId = pokemonId else { return }
        let pokemonIdAsString = String(describing: pokemonId)
        let endpoint = "\(API.PokemonsEndpoint)/\(pokemonIdAsString)"
        dataManager.getData(endpoint: endpoint, Pokemon.self) { (result, error) in
            guard error == nil, result != nil, let pokemon = result as! Pokemon? else {
                completion(nil)
                return
            }
            self.pokemon = pokemon
            completion(pokemon)
        }
    }
    
    func getPokemonImage(completion: @escaping ImageDataCompletion) {
        guard let pokemon = pokemon else { return }
        guard let pokemonNumber = pokemon.dexNumber else { return }
        apiClient.getImageData(pokemonNumber: String(describing: pokemonNumber)) { (result, error) in
            guard error == nil, result != nil else {
                completion(nil, .FailedRequest)
                return
            }
            completion(result, nil)
        }
    }
}
