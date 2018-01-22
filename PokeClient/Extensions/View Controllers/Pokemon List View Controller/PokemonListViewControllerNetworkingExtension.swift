//
//  PokemonListViewControllerNetworkingExtension.swift
//  PokeClient
//
//  Created by Tiago Santos on 22/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

extension PokemonListViewController {
    internal func getPokemonData() {
        dataManager.getData(endpoint: API.PokemonEndpoint) { (response, error) in
            guard let pokemonListFromResponse = response as! [Pokemon]? else { return }
            self.pokemonList = pokemonListFromResponse
            self.pokemonTableView.reloadData()
        }
    }
}
