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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastInitialDisplayableCell = checkIfCellIsLastInitialDisplayableCell(indexPath: indexPath)
        
        if !finishedLoadingInitialTableCells {
            finishedLoadingInitialTableCells = lastInitialDisplayableCell
            let tableViewHeight = pokemonTableView.bounds.size.height
            animateCellLoad(cell, tableViewHeight)
        }
    }
}

// MARK: - Animations
extension PokemonListViewController {
    private func animateCellLoad(_ cell: UITableViewCell, _ tableViewHeight: CGFloat) {
        cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        
        UIView.animate(withDuration: 1.5, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            cell.transform = CGAffineTransform.identity
        }, completion: nil)
        delayCounter += 1
    }
    
    func checkIfCellIsLastInitialDisplayableCell(indexPath: IndexPath) -> Bool {
        guard !finishedLoadingInitialTableCells else { return false }
        guard let indexPathForVisibleRows = pokemonTableView.indexPathsForVisibleRows,
            let lastIndexPath = indexPathForVisibleRows.last,
            lastIndexPath.row == indexPath.row else { return false }
        return true
    }
}

// MARK: - Gets
extension PokemonListViewController {
    func getPokemonToCell(indexPath: IndexPath) -> Pokemon {
        guard isFiltering() else { return pokemonList[indexPath.row] }
        return filteredPokemons[indexPath.row]
    }
}

// MARK: - Sets
extension PokemonListViewController {
    private func setCellImage(_ pokemonNumber: Int, _ pokemonCell: PokemonCell) {
        pokemonListViewModel.getImageData(pokemonNumber: pokemonNumber) { (data, error) in
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
        let dexNumberString = pokemonListViewModel.getDexNumberString(pokemonNumber: pokemonNumber)
        pokemonCell.dexNumberLabel.text = dexNumberString
    }
}
