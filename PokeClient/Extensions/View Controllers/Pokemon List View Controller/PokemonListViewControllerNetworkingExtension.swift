//
//  PokemonListViewControllerNetworkingExtension.swift
//  PokeClient
//
//  Created by Tiago Santos on 22/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

extension PokemonListViewController {
    
    // 🍄 TODO: Get a "light" version of the Pokémon for the list. New request performed when asked for the detail page. 🍄
    internal func getPokemonData() {
        dataManager.getData(endpoint: API.PokemonEndpoint) { (response, error) in
            guard let pokemonListFromResponse = response as! [Pokemon]? else { return }
            self.pokemonList = pokemonListFromResponse
            
            DispatchQueue.main.async {
                self.pokemonTableView.reloadData()
            }
        }
    }
}
