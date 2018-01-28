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
    private var pokemon: Pokemon!
    
    init(pokemon: Pokemon, pokemonDetailsViewController: PokemonDetailsViewController, pokemonListViewController: PokemonListViewController) {
        self.pokemon = pokemon
        self.pokemonDetailsViewController = pokemonDetailsViewController
        self.pokemonListViewController = pokemonListViewController
    }
}
