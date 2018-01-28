//
//  PokemonDetailsViewModel.swift
//  PokeClient
//
//  Created by Tiago Santos on 28/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

class PokemonDetailsViewModel {
    
    private var pokemonDetailsViewController: PokemonDetailsViewController!
    private var pokemonListViewController: PokemonListViewController!
    private var pokemon: Pokemon!
    
    internal var apiClient: ApiClient!
    
    init(pokemon: Pokemon, pokemonDetailsViewController: PokemonDetailsViewController, pokemonListViewController: PokemonListViewController) {
        self.pokemon = pokemon
        self.pokemonDetailsViewController = pokemonDetailsViewController
        self.pokemonListViewController = pokemonListViewController
        apiClient = ApiClient(baseUrl: API.ImageUrl)
    }
    
    func setupViewController() {
        setupLabels()
        setupNavigationController()
    }
}

// MARK: - Setups
extension PokemonDetailsViewModel {
    private func setupLabels() {
        guard let pokemon = pokemon else { return }
        
        guard let pokemonNumber = pokemon.dexNumber else { return }
        guard let pokemonName = pokemon.name else { return }
        guard let pokemonHeight = pokemon.height else { return }
        guard let pokemonWeight = pokemon.weight else { return }
        guard let pokemonType = pokemon.type else { return }
        
        pokemonDetailsViewController.numberLabel.text = String(describing: pokemonNumber)
        pokemonDetailsViewController.nameLabel.text = String(describing: pokemonName)
        pokemonDetailsViewController.heightLabel.text = "\(String(describing: pokemonHeight)) m"
        pokemonDetailsViewController.weightLabel.text = "\(String(describing: pokemonWeight)) kg"
        pokemonDetailsViewController.typeLabel.text = String(describing: pokemonType)
    }
    
    private func setupNavigationController() {
        pokemonDetailsViewController.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pokemonDetailsViewController.navigationController?.isToolbarHidden = true
        pokemonDetailsViewController.navigationItem.title = "Details"
        pokemonDetailsViewController.editButton = UIBarButtonItem(title: "Edit", style: .plain, target: pokemonDetailsViewController, action: #selector(editButtonTapped))
        pokemonDetailsViewController.navigationItem.setRightBarButton(pokemonDetailsViewController.editButton, animated: true)
    }
}

// MARK: - Selectors
extension PokemonDetailsViewModel {
    @objc func editButtonTapped() {
        guard let pokemon = pokemon else { return }
        let editPokemonViewController = NewPokemonViewController(pokemon: pokemon, pokemonListViewController: pokemonListViewController!)
        pokemonDetailsViewController.present(editPokemonViewController, animated: true, completion: nil)
    }
}
