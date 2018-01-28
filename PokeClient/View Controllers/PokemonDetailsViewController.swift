//
//  PokemonDetailsViewController.swift
//  PokeClient
//
//  Created by Tiago Santos on 22/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit
import Reachability

class PokemonDetailsViewController: UIViewController {

    internal var pokemon: Pokemon?
    internal var pokemonDetailsViewModel: PokemonDetailsViewModel!
    internal var pokemonListViewController: PokemonListViewController?
    internal var reachability: Reachability!
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    convenience init(pokemon: Pokemon, pokemonListViewController: PokemonListViewController) {
        self.init()
        self.pokemon = pokemon
        self.pokemonListViewController = pokemonListViewController
        self.pokemonDetailsViewModel = PokemonDetailsViewModel(pokemon: pokemon, pokemonDetailsViewController: self, pokemonListViewController: pokemonListViewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    private func setupViewController() {
        setupLabels()
        setupNavigationController()
        startNotifier()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserver()
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
        
        numberLabel.text = String(describing: pokemonNumber)
        nameLabel.text = String(describing: pokemonName)
        heightLabel.text = "\(String(describing: pokemonHeight)) m"
        weightLabel.text = "\(String(describing: pokemonWeight)) kg"
        typeLabel.text = String(describing: pokemonType)
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
        let editPokemonViewController = NewPokemonViewController(pokemon: pokemon, pokemonListViewController: pokemonListViewController!)
        present(editPokemonViewController, animated: true, completion: nil)
    }
}
