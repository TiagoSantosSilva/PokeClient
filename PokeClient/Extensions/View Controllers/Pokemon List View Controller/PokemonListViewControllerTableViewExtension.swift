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
        setPokemonNumber(pokemonNumber: pokemonNumber, pokemonCell: pokemonCell)
        
        pokemonCell.pokemonNameLabel.text = pokemon.name
        pokemonCell.pokemonListViewController = self
        
        setCellImage(pokemonNumber, pokemonCell)
        return pokemonCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    // MARK: - Gets
    func getPokemonToCell(indexPath: IndexPath) -> Pokemon {
        guard isFiltering() else { return pokemonList[indexPath.row] }
        return filteredPokemons[indexPath.row]
    }
    
    // MARK: - Sets
    private func setCellImage(_ pokemonNumber: Int, _ pokemonCell: PokemonCell) {
        apiClient.getPokemonImageData(pokemonNumber: String(describing: pokemonNumber)) { (data, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    pokemonCell.pokemonImage.image = UIImage(named: "unkown")
                }
                return
            }
            
            guard let imageData = data else {
                DispatchQueue.main.async {
                    pokemonCell.pokemonImage.image = UIImage(named: "unkown")
                }
                return
            }
            DispatchQueue.main.async {
                pokemonCell.pokemonImage.image = UIImage(data: imageData)
            }
        }
    }
    
    private func setPokemonNumber(pokemonNumber: Int, pokemonCell: PokemonCell) {
        var digitCount = pokemonNumber.numberOfDigits()
        var dexNumberString = "#"
        
        while digitCount < 3 {
            dexNumberString = "\(dexNumberString)0"
            digitCount += 1
        }
        dexNumberString = "\(dexNumberString)\(pokemonNumber)"
        
        pokemonCell.dexNumberLabel.text = dexNumberString
    }
}
