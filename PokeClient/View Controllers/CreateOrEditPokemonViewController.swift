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

class CreateOrEditPokemonViewController: BaseViewController {
    
    internal var newPokemonViewModel: NewPokemonViewModel!
    internal var pokemon: Pokemon?
    internal var pokemonListViewController: PokemonListViewController!
    internal var pokemonDetailsViewController: PokemonDetailsViewController!
    internal var pokemonTypes: [PokemonType]!
    internal var indexOfPokemonCell: IndexPath!
    
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    convenience init(indexPath: IndexPath, pokemon: Pokemon, pokemonTypes: [PokemonType], pokemonDetailsViewController: PokemonDetailsViewController) {
        self.init()
        self.indexOfPokemonCell = indexPath
        self.pokemon = pokemon
        self.pokemonDetailsViewController = pokemonDetailsViewController
        self.newPokemonViewModel = NewPokemonViewModel()
        self.pokemonTypes = pokemonTypes
    }
    
    convenience init(pokemonTypes: [PokemonType], pokemonListViewController: PokemonListViewController) {
        self.init()
        self.pokemonListViewController = pokemonListViewController
        self.newPokemonViewModel = NewPokemonViewModel()
        self.pokemonTypes = pokemonTypes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
