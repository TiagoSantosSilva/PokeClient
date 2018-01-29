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
    private var pokemonId: Int!
    
    internal var dataManager: DataManager!
    
    init(pokemonId: Int, pokemonDetailsViewController: PokemonDetailsViewController, pokemonListViewController: PokemonListViewController) {
        self.pokemonId = pokemonId
        self.pokemonDetailsViewController = pokemonDetailsViewController
        self.pokemonListViewController = pokemonListViewController
        self.dataManager = DataManager(baseUrl: API.BaseUrl)
    }
    
    func getPokemonById(completion: @escaping PokemonCompletion) {
        guard let pokemonId = pokemonId else { return }
        let endpoint = "\(API.PokemonsEndpoint)/\(pokemonId)"
        dataManager.getData(endpoint: endpoint, Pokemon.self) { (result, error) in
            guard error == nil, result != nil, let pokemon = result as! Pokemon? else {
                completion(nil)
                return
            }
            completion(pokemon)
        }
    }
}
