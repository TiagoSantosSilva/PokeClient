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
        
        pokemonListViewModel.getData { (pokemonList) in
            guard let pokemonList = pokemonList else { return }
            self.pokemonList = pokemonList
            
            DispatchQueue.main.async {
                self.pokemonTableView.reloadData()
            }
        }
    }
}
