//
//  PokemonListViewControllerDeepLinkingExtension.swift
//  PokeClient
//
//  Created by Tiago Santos on 01/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

extension PokemonListViewController {
    internal func handleDeepLinkingUrl() {
        guard let url = urlUsedToOpenApp else { return }
        guard let pokemonIdAsDexNumber = pokemonListViewModel.getPokemonIdAsPokedexNumber(url: url) else { return }
        guard let pokemonCellToPush = getPokemonCellByPokemonDexNumber(pokemonIdAsDexNumber: pokemonIdAsDexNumber) else { return }
        guard let pokemonId = getTappedPokemonId(cell: pokemonCellToPush) else { return }
        guard let cellIndexPath = pokemonTableView.indexPath(for: pokemonCellToPush) else { return }
        
        let pokemonDetailsViewController = PokemonDetailsViewController(indexPath: cellIndexPath, pokemonId: pokemonId, pokemonTypes: pokemonTypes, pokemonListViewController: self)
        navigationController?.pushViewController(pokemonDetailsViewController, animated: true)
    }
    
    internal func getPokemonCellByPokemonDexNumber(pokemonIdAsDexNumber: String) -> PokemonCell? {
        for cell in pokemonTableView.visibleCells {
            guard let pokemonCell = cell as? PokemonCell else {
                // TODO: - Alert Controller
                return nil
            }
            if pokemonCell.dexNumberLabel.text == pokemonIdAsDexNumber {
                return pokemonCell
            }
        }
        return nil
    }
}
