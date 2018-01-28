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

    internal var editButton: UIBarButtonItem!
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
        self.pokemonListViewController = pokemonListViewController
        self.pokemonDetailsViewModel = PokemonDetailsViewModel(pokemon: pokemon, pokemonDetailsViewController: self, pokemonListViewController: pokemonListViewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    private func setupController() {
        pokemonDetailsViewModel.setupViewController()
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
