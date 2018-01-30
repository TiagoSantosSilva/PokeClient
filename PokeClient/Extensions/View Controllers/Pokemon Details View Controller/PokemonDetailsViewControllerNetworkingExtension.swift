//
//  PokemonDetailsViewControllerNetworkingExtension.swift
//  PokeClient
//
//  Created by Tiago Santos on 29/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

extension PokemonDetailsViewController {
    func getPokemon(completion: @escaping BooleanCompletion) {
        pokemonDetailsViewModel.getPokemonById { (pokemon) in
            guard let pokemon = pokemon else { return }
            self.pokemon = pokemon
            completion(true)
        }
        completion(false)
    }
    
    func setPokemonImage() {
        pokemonDetailsViewModel.getPokemonImage { (result, error) in
            guard let result = result else {
                
                DispatchQueue.main.async {
                    self.pokemonImage.image = UIImage(named: "unkown")
                }
                return
            }
            
            DispatchQueue.main.async {
                self.pokemonImage.image = UIImage(data: result)
            }
        }
    }
}
