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

class NewPokemonViewController: BaseViewController {
    
    internal var newPokemonViewModel: NewPokemonViewModel!
    internal var pokemon: Pokemon?
    internal var pokemonListViewController: PokemonListViewController!
    
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    
    convenience init(pokemon: Pokemon, pokemonListViewController: PokemonListViewController) {
        self.init()
        self.pokemon = pokemon
        self.pokemonListViewController = pokemonListViewController
        self.newPokemonViewModel = NewPokemonViewModel()
    }
    
    convenience init(pokemonListViewController: PokemonListViewController) {
        self.init()
        self.pokemonListViewController = pokemonListViewController
        self.newPokemonViewModel = NewPokemonViewModel()
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
extension NewPokemonViewController {
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okButtonTapped(_ sender: Any) {
        createOrEditPokemon()
    }
}

// MARK: - Handlers
extension NewPokemonViewController {
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
        self.pokemonListViewController.pokemonEdited(pokemon: pokemonFromRequest)
        self.dismiss(animated: true, completion: nil)
    }
}

extension NewPokemonViewController {
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
extension NewPokemonViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pokemonTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pokemonTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeField.text = pokemonTypes[row]
    }
    
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
