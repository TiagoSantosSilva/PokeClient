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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

// MARK: - IBActions
extension CreateOrEditPokemonViewController {
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okButtonTapped(_ sender: Any) {
        createOrEditPokemon()
    }
}

// MARK: - Handlers
extension CreateOrEditPokemonViewController {
    internal func createOrEditPokemon() {
        guard let pokemonInView = getPokemonInViewData() else { return }
        
        newPokemonViewModel.performRequest(pokemon: pokemonInView) { (pokemonFromRequest) in
            guard let pokemonFromRequest = pokemonFromRequest else { return }
            self.handlePokemonRequestResult(pokemonFromRequest: pokemonFromRequest)
        }
    }
    
    internal func handlePokemonRequestResult(pokemonFromRequest: Pokemon) {
        guard self.pokemon != nil else {
            self.pokemonListViewController.newPokemonCreated(pokemon: pokemonFromRequest)
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        self.pokemonDetailsViewController.pokemonEdited(pokemon: pokemonFromRequest)
        self.dismiss(animated: true, completion: nil)
    }
}

extension CreateOrEditPokemonViewController {
    internal func getPokemonInViewData() -> Pokemon? {
        guard let number = numberField.text else { return nil }
        guard let name = nameField.text else { return nil }
        guard let height = heightField.text else { return nil }
        guard let weight = weightField.text else { return nil }
        guard let type = typeField.text else { return nil }
        
        let pokemonToReturn = Pokemon(id: pokemon?.id, dexNumber: Int(number), name: name, height: Float(height), weight: Float(weight), type: type)
        return pokemonToReturn
    }
}

// MARK: - Setups
extension CreateOrEditPokemonViewController {    
    internal func setupView() {
        setTextFieldContents()
        setTypePickerView()
    }
    
    internal func setTextFieldContents() {
        guard let pokemon = pokemon else { return }
        
        guard let pokemonNumber = pokemon.dexNumber else { return }
        guard let pokemonName = pokemon.name else { return }
        guard let pokemonHeight = pokemon.height else { return }
        guard let pokemonWeight = pokemon.weight else { return }
        guard let pokemonType = pokemon.type else { return }
        
        numberField.text = String(describing: pokemonNumber)
        nameField.text = String(describing: pokemonName)
        heightField.text = String(describing: pokemonHeight)
        weightField.text = String(describing: pokemonWeight)
        typeField.text = String(describing: pokemonType)
    }
    
    internal func setTypePickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        typeField.inputView = pickerView
    }
}
