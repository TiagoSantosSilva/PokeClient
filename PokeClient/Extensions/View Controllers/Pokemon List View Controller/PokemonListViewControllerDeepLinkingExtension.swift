//
//  PokemonListViewControllerDeepLinkingExtension.swift
//  PokeClient
//
//  Created by Tiago Santos on 01/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

extension PokemonListViewController {
    internal func handleDeepLinkingUrl() {
        guard let url = urlUsedToOpenApp else { return }
        handleLinkQuery(query: url.query)
    }
    
    func handleLinkQuery(query: String?) {
        guard let query = query else { return }
        
        if query.contains("pokemon_number=") {
            handlePokemonNumberQuery(query: query)
            // return
        }
        
        if query.contains("pokemon_filter=") {
            handlePokemonFilterQuery(query: query)
            // return
        }
    }
    
    func handlePokemonNumberQuery(query: String) {
        
        //TODO: - Call a single view model function.
        guard let pokemonNumber = pokemonListViewModel.getDataFromQuery(contentToRemove: "pokemon_number=", query: query) else { return }
        guard let pokemonNumberAsDexNumber = pokemonListViewModel.getPokemonIdAsPokedexNumberFromQuery(pokemonIdFromQuery: pokemonNumber) else { return }
        
        guard let pokemonCellToPush = getPokemonCellByPokemonDexNumber(pokemonNumberAsDexNumber: pokemonNumberAsDexNumber) else { return }
        guard let pokemonId = getTappedPokemonId(cell: pokemonCellToPush) else { return }
        guard let cellIndexPath = pokemonTableView.indexPath(for: pokemonCellToPush) else { return }
        
        let pokemonDetailsViewController = PokemonDetailsViewController(indexPath: cellIndexPath, pokemonId: pokemonId, pokemonTypes: pokemonTypes, pokemonListViewController: self)
        navigationController?.pushViewController(pokemonDetailsViewController, animated: true)
    }
    
    // TODO
    func handlePokemonFilterQuery(query: String) {
        guard let filter = pokemonListViewModel.getDataFromQuery(contentToRemove: "pokemon_filter=", query: query) else { return }
        
    }
    
    internal func getPokemonCellByPokemonDexNumber(pokemonNumberAsDexNumber: String) -> PokemonCell? {
        for cell in pokemonTableView.visibleCells {
            guard let pokemonCell = cell as? PokemonCell else {
                // TODO: - Alert Controller
                return nil
            }
            if pokemonCell.dexNumberLabel.text == pokemonNumberAsDexNumber {
                return pokemonCell
            }
        }
        return nil
    }
}
