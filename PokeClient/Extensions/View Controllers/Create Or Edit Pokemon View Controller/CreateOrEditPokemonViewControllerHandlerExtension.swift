//
//  CreateOrEditPokemonViewControllerHandlerExtension.swift
//  PokeClient
//
//  Created by Tiago Santos on 30/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

// MARK: - Handlers
extension CreateOrEditPokemonViewController {
    internal func createOrEditPokemon() {
        guard let pokemonInView = getPokemonInViewData() else { return }
        
        newPokemonViewModel.performRequest(pokemon: pokemonInView) { (pokemonFromRequest) in
            guard let pokemonFromRequest = pokemonFromRequest else { return }
            self.handlePokemonRequestResult(pokemonFromRequest: pokemonFromRequest)
        }
    }
    
    internal func handlePokemonRequestResult(pokemonFromRequest: Pokemon) {
        guard self.pokemon != nil else {
            self.pokemonListViewController.newPokemonCreated(pokemon: pokemonFromRequest)
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        self.pokemonDetailsViewController.pokemonEdited(pokemon: pokemonFromRequest)
        self.dismiss(animated: true, completion: nil)
    }
}
