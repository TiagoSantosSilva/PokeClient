//
//  PokemonListViewControllerTableViewExtension.swift
//  PokeClient
//
//  Created by Tiago Santos on 22/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

extension PokemonListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard isFiltering() else { return pokemonList.count }
        return filteredPokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pokemonCell = pokemonTableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? PokemonCell else { return UITableViewCell() }
        let pokemon = getPokemonToCell(indexPath: indexPath)
        
        guard let pokemonNumber = pokemon.dexNumber else { return UITableViewCell() }
        pokemonCell.dexNumberLabel.text = "#\(String(describing: pokemonNumber))"
        pokemonCell.pokemonNameLabel.text = pokemon.name
        pokemonCell.pokemonListViewController = self
        return pokemonCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func getPokemonToCell(indexPath: IndexPath) -> Pokemon {
        guard isFiltering() else { return pokemonList[indexPath.row] }
        return filteredPokemons[indexPath.row]
    }
}
