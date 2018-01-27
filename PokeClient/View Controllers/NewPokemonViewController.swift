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
    
    internal var dataManager = DataManager<Pokemon>(baseUrl: API.BaseUrl)
    internal var pokemon: Pokemon?
    internal var pokemonListViewController: PokemonListViewController!
    internal var reachability: Reachability!
    
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    
    convenience init(pokemon: Pokemon, pokemonListViewController: PokemonListViewController) {
        self.init()
        self.pokemon = pokemon
        self.pokemonListViewController = pokemonListViewController
    }
    
    convenience init(pokemonListViewController: PokemonListViewController) {
        self.init()
        self.pokemonListViewController = pokemonListViewController
    }
    
    fileprivate func setTextFieldContents() {
        typeField.text = "SCROLL VIEW PLACEHOLDER"
        guard let pokemon = self.pokemon else { return }
        
        guard let pokemonNumber = pokemon.dexNumber else { return }
        guard let pokemonName = pokemon.name else { return }
        guard let pokemonHeight = pokemon.height else { return }
        guard let pokemonWeight = pokemon.weight else { return }
        
        numberField.text = String(describing: pokemonNumber)
        nameField.text = String(describing: pokemonName)
        heightField.text = String(describing: pokemonHeight)
        weightField.text = String(describing: pokemonWeight)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldContents()
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
        preparePokemonData()
    }
    
    func getPokemonInViewData() -> Pokemon? {
        guard let number = numberField.text else { return nil }
        guard let name = nameField.text else { return nil }
        guard let height = heightField.text else { return nil }
        guard let weight = weightField.text else { return nil }
        let type = "Grass"
        
        let pokemonToReturn = Pokemon(id: pokemon?.id, dexNumber: Int(number), name: name, height: Float(height), weight: Float(weight), type: type)
        return pokemonToReturn
    }
    
    func preparePokemonData() {
        let pokemonInView = getPokemonInViewData()
        guard let pokemonToSend = pokemonInView else { return }
        
        let encodedPokemon = try? JSONEncoder().encode(pokemonToSend) as Data
        guard let data = encodedPokemon else { return }
        
        let requestTuple = getRequestEndpointAndMethod(pokemonToSendId: pokemonToSend.id)
        let requestEndpoint = requestTuple.0
        let requestMethod = requestTuple.1
        
        guard pokemon != nil else {
            createPokemon(requestEndpoint: requestEndpoint, data: data, requestMethod: requestMethod)
            return
        }
         editPokemon(requestEndpoint: requestEndpoint, data: data, requestMethod: requestMethod)
    }
    
    func createPokemon(requestEndpoint: String, data: Data, requestMethod: String) {
        sendRequest(forRequestEndpoint: requestEndpoint, data: data, andRequestMethod: requestMethod) { (pokemon) in
            guard let pokemon = pokemon else { return }
            self.pokemonListViewController.newPokemonCreated(pokemon: pokemon)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func editPokemon(requestEndpoint: String, data: Data, requestMethod: String) {
        sendRequest(forRequestEndpoint: requestEndpoint, data: data, andRequestMethod: requestMethod) { (pokemon) in
            guard let pokemon = pokemon else { return }
            self.pokemonListViewController.pokemonEdited(pokemon: pokemon)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func getRequestEndpointAndMethod(pokemonToSendId: Int?) -> (String, String) {
        guard let pokemonId = pokemonToSendId else {
            return (endpoint: API.PokemonEndpoint, method: "POST")
        }
        return (endpoint: "\(API.PokemonEndpoint)/\(String(describing: pokemonId))", method: "PUT")
    }
    
    private func sendRequest(forRequestEndpoint requestEndpoint: String, data: Data, andRequestMethod requestMethod: String, _ completion: @escaping PokemonCompletion) {
        dataManager.postData(endpoint: requestEndpoint, data: data, method: requestMethod) { (result, error) in
            guard let pokemon = result as? Pokemon else {
                // Present Alert Controller
                completion(nil)
                return
            }
            completion(pokemon)
        }
    }
}
