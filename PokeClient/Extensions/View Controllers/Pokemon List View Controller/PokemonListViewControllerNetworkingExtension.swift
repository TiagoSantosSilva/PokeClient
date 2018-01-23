//
//  PokemonListViewControllerNetworkingExtension.swift
//  PokeClient
//
//  Created by Tiago Santos on 22/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

extension PokemonListViewController {
    internal func getPokemonData() {
        dataManager.getData(endpoint: API.PokemonEndpoint) { (response, error) in
            guard let pokemonListFromResponse = response as! [Pokemon]? else { return }
            self.pokemonList = pokemonListFromResponse
            self.pokemonTableView.reloadData()
        }
    }
    
    internal func setupPokemonImage(pokemon: Pokemon) -> UIImage {
        var pokemonImageData: Data?
        
        guard let pokemonDexNumber = pokemon.dexNumber else {
            return UIImage(named: "unknown")!
        }
        
        apiClient.getPokemonImageData(pokemonNumber: String(describing: pokemonDexNumber)) { (data, error) in
            guard error == nil, let imageData = data else {
                print("Image fetch error. 🚨")
                return
            }
            pokemonImageData = imageData
        }
        
        guard let data = pokemonImageData else { return UIImage(named: "unkown")! }
        return UIImage(data: data)!
    }
}
