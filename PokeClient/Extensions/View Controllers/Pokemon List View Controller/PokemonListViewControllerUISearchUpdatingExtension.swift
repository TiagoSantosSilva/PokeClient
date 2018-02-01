//
//  PokemonListViewControllerUISearchExtension.swift
//  PokeClient
//
//  Created by Tiago Santos on 22/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

extension PokemonListViewController: UISearchResultsUpdating {
    internal func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
    
    internal func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    internal func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredPokemons = pokemonList.filter({ (pokemon: Pokemon) -> Bool in
            let doesCategoryMatch = (scope == "All") || (pokemon.type == scope)
            
            if searchBarIsEmpty() {
                return doesCategoryMatch
            }
            
            return doesCategoryMatch && (pokemon.name?.lowercased().contains(searchText.lowercased()))!
        })
        
        pokemonTableView.reloadData()
    }
    
    internal func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
}
