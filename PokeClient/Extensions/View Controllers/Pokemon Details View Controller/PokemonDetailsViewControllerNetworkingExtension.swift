//
//  PokemonDetailsViewControllerNetworkingExtension.swift
//  PokeClient
//
//  Created by Tiago Santos on 29/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

extension PokemonDetailsViewController {
    func getPokemon(completion: @escaping BooleanCompletion) {
        pokemonDetailsViewModel.getPokemonById { (pokemon) in
            guard let pokemon = pokemon else { return }
            self.pokemon = pokemon
            completion(true)
        }
        completion(false)
    }
}
