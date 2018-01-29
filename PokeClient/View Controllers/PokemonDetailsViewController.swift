//
//  PokemonDetailsViewController.swift
//  PokeClient
//
//  Created by Tiago Santos on 22/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit
import Reachability

class PokemonDetailsViewController: BaseViewController {

    internal var pokemonId: Int!
    internal var pokemon: Pokemon!
    
    internal var pokemonDetailsViewModel: PokemonDetailsViewModel!
    internal var pokemonListViewController: PokemonListViewController?
    
    internal var pokemonTypes: [PokemonType]!
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    convenience init(pokemonId: Int, pokemonTypes: [PokemonType], pokemonListViewController: PokemonListViewController) {
        self.init()
        self.pokemonId = pokemonId
        self.pokemonTypes = pokemonTypes
        self.pokemonListViewController = pokemonListViewController
        self.pokemonDetailsViewModel = PokemonDetailsViewModel(pokemonId: pokemonId, pokemonDetailsViewController: self, pokemonListViewController: pokemonListViewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    private func setupViewController() {
        getPokemon { (pokemonFetched) in
            if pokemonFetched {
                self.setupLabels()
            }
        }
        self.setupNavigationController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - Setups
extension PokemonDetailsViewController {
    private func setupLabels() {
        guard let pokemon = pokemon else { return }
        
        guard let pokemonNumber = pokemon.dexNumber else { return }
        guard let pokemonName = pokemon.name else { return }
        guard let pokemonHeight = pokemon.height else { return }
        guard let pokemonWeight = pokemon.weight else { return }
        guard let pokemonType = pokemon.type else { return }
        
        DispatchQueue.main.async {
            self.numberLabel.text = String(describing: pokemonNumber)
            self.nameLabel.text = String(describing: pokemonName)
            self.heightLabel.text = "\(String(describing: pokemonHeight)) m"
            self.weightLabel.text = "\(String(describing: pokemonWeight)) kg"
            self.typeLabel.text = String(describing: pokemonType)
        }
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.isToolbarHidden = true
        navigationItem.title = "Details"
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonTapped))
        navigationItem.setRightBarButton(editButton, animated: true)
    }
}

// MARK: - Selectors
extension PokemonDetailsViewController {
    @objc func editButtonTapped() {
        guard let pokemon = pokemon else { return }
        let editPokemonViewController = NewPokemonViewController(pokemon: pokemon, pokemonTypes: pokemonTypes, pokemonListViewController: pokemonListViewController!)
        present(editPokemonViewController, animated: true, completion: nil)
    }
}
