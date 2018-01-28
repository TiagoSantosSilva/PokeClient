//
//  NewPokemonViewModel.swift
//  PokeClient
//
//  Created by Tiago Santos on 27/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

class NewPokemonViewModel {
    
    internal var dataManager: DataManager<Pokemon>
    internal var newPokemonViewController: NewPokemonViewController!
    internal var actualPokemon: Pokemon?
    
    init(newPokemonViewController: NewPokemonViewController, pokemon: Pokemon?) {
        self.newPokemonViewController = newPokemonViewController
        self.actualPokemon = pokemon
        dataManager = DataManager<Pokemon>(baseUrl: API.BaseUrl)
    }
}

// MARK: - Setups
extension NewPokemonViewModel {
    func setupView() {
        setTextFieldContents()
    }
    
    private func setTextFieldContents() {
        newPokemonViewController.typeField.text = "SCROLL VIEW PLACEHOLDER"
        guard let pokemon = self.actualPokemon else { return }
        
        guard let pokemonNumber = pokemon.dexNumber else { return }
        guard let pokemonName = pokemon.name else { return }
        guard let pokemonHeight = pokemon.height else { return }
        guard let pokemonWeight = pokemon.weight else { return }
        
        newPokemonViewController.numberField.text = String(describing: pokemonNumber)
        newPokemonViewController.nameField.text = String(describing: pokemonName)
        newPokemonViewController.heightField.text = String(describing: pokemonHeight)
        newPokemonViewController.weightField.text = String(describing: pokemonWeight)
    }
}

// MARK: - Data Handling
extension NewPokemonViewModel {
    private func getPokemonInViewData() -> Pokemon? {
        guard let number = newPokemonViewController.numberField.text else { return nil }
        guard let name = newPokemonViewController.nameField.text else { return nil }
        guard let height = newPokemonViewController.heightField.text else { return nil }
        guard let weight = newPokemonViewController.weightField.text else { return nil }
        let type = "Grass"
        
        let pokemonToReturn = Pokemon(id: actualPokemon?.id, dexNumber: Int(number), name: name, height: Float(height), weight: Float(weight), type: type)
        return pokemonToReturn
    }
    
    private func getRequestEndpointAndMethod(pokemonToSendId: Int?) -> (String, String) {
        guard let pokemonId = pokemonToSendId else {
            return (endpoint: API.PokemonEndpoint, method: "POST")
        }
        return (endpoint: "\(API.PokemonEndpoint)/\(String(describing: pokemonId))", method: "PUT")
    }
    
    func preparePokemonData() {
        let pokemonInView = getPokemonInViewData()
        guard let pokemonToSend = pokemonInView else { return }
        
        let encodedPokemon = try? JSONEncoder().encode(pokemonToSend) as Data
        guard let data = encodedPokemon else { return }
        
        let requestTuple = getRequestEndpointAndMethod(pokemonToSendId: pokemonToSend.id)
        let requestEndpoint = requestTuple.0
        let requestMethod = requestTuple.1
        
        performRequest(requestEndpoint: requestEndpoint, data: data, requestMethod: requestMethod)
    }
}

// MARK: - Requests
extension NewPokemonViewModel {
    private func performRequest(requestEndpoint: String, data: Data, requestMethod: String) {
        guard actualPokemon != nil else {
            createPokemon(requestEndpoint: requestEndpoint, data: data, requestMethod: requestMethod)
            return
        }
        editPokemon(requestEndpoint: requestEndpoint, data: data, requestMethod: requestMethod)
    }
    
    private func sendPokemonRequest(forRequestEndpoint requestEndpoint: String, data: Data, andRequestMethod requestMethod: String, _ completion: @escaping PokemonCompletion) {
        dataManager.postData(endpoint: requestEndpoint, data: data, method: requestMethod) { (result, error) in
            guard let pokemon = result as? Pokemon else {
                // TODO: Present Alert Controller
                completion(nil)
                return
            }
            completion(pokemon)
        }
    }
    
    private func createPokemon(requestEndpoint: String, data: Data, requestMethod: String) {
        sendPokemonRequest(forRequestEndpoint: requestEndpoint, data: data, andRequestMethod: requestMethod) { (pokemon) in
            guard let pokemon = pokemon else { return }
            self.newPokemonViewController.pokemonListViewController.newPokemonCreated(pokemon: pokemon)
            self.newPokemonViewController.dismiss(animated: true, completion: nil)
        }
    }
    
    private func editPokemon(requestEndpoint: String, data: Data, requestMethod: String) {
        sendPokemonRequest(forRequestEndpoint: requestEndpoint, data: data, andRequestMethod: requestMethod) { (pokemon) in
            guard let pokemon = pokemon else { return }
            self.newPokemonViewController.pokemonListViewController.pokemonEdited(pokemon: pokemon)
            self.newPokemonViewController.dismiss(animated: true, completion: nil)
        }
    }
}
