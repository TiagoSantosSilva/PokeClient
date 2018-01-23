//
//  NewPokemonViewController.swift
//  PokeClient
//
//  Created by Tiago Santos on 21/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

class NewPokemonViewController: UIViewController {

    var dataManager = DataManager<Pokemon>(baseUrl: API.BaseUrl)
    
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    
    var pokemonListViewController: PokemonListViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension NewPokemonViewController {
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okButtonTapped(_ sender: Any) {
       createPokemon()
    }
    
    func createPokemon() {
        guard let number = numberField.text else { return }
        guard let name = nameField.text else { return }
        guard let height = heightField.text else { return }
        guard let weight = weightField.text else { return }
        let type = "Grass"
        
        let pokemon = Pokemon(id: nil, dexNumber: Int(number), name: name, height: Float(height), weight: Float(weight), type: type)
        let encodedPokemon = try? JSONEncoder().encode(pokemon) as Data
        guard let data = encodedPokemon else { return }
        
        dataManager.postData(endpoint: API.PokemonEndpoint, data: data) { (result, error) in
            guard let pokemon = result as? Pokemon else {
                // Present Alert Controller
                return
            }
            
            self.pokemonListViewController.newPokemonCreated(pokemon: pokemon)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
