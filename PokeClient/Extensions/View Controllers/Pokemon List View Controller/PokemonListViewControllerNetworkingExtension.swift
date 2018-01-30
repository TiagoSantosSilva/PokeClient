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
        
        pokemonListViewModel.getPokemons { (pokemonList) in
            guard let pokemonList = pokemonList else { return }
            self.pokemonList = pokemonList
            
            DispatchQueue.main.async {
                self.pokemonTableView.reloadData()
            }
        }
    }
    
    internal func getPokemonTypes() {
        pokemonListViewModel.getTypes { (pokemonTypeList) in
            guard let pokemonTypeList = pokemonTypeList else { return }
            self.pokemonTypes = pokemonTypeList
        }
    }
    
    internal func loadPaginatedData() {
        pokemonListViewModel.getPokemons({ (pokemons) in
            
            guard let pokemons = pokemons else { return }
            for pokemon in pokemons {
                self.pokemonList.append(pokemon)
            }
            self.pokemonTableView.reloadData()
        })
    }
}
