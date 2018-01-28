//
//  NewPokemonViewController.swift
//  PokeClient
//
//  Created by Tiago Santos on 21/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit
import Reachability

typealias PokemonCompletion = (Pokemon?) -> ()

class NewPokemonViewController: UIViewController {
    
    internal var newPokemonViewModel: NewPokemonViewModel!
    internal var pokemon: Pokemon?
    internal var pokemonListViewController: PokemonListViewController!
    internal var reachability: Reachability!
    
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    
    convenience init(pokemon: Pokemon, pokemonListViewController: PokemonListViewController) {
        self.init()
        self.pokemon = pokemon
        self.pokemonListViewController = pokemonListViewController
        self.newPokemonViewModel = NewPokemonViewModel(newPokemonViewController: self, pokemon: pokemon)
    }
    
    convenience init(pokemonListViewController: PokemonListViewController) {
        self.init()
        self.pokemonListViewController = pokemonListViewController
        self.newPokemonViewModel = NewPokemonViewModel(newPokemonViewController: self, pokemon: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newPokemonViewModel.setupView()
        startNotifier()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserver()
    }
}

extension NewPokemonViewController {
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okButtonTapped(_ sender: Any) {
        newPokemonViewModel.preparePokemonData()
    }
}
