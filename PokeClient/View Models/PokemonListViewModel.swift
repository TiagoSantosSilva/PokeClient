//
//  PokemonListViewModel.swift
//  PokeClient
//
//  Created by Tiago Santos on 28/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

typealias PokemonListCompletion = ([Pokemon]?) -> ()
typealias PokemonTypeListCompletion = ([PokemonType]?) -> ()

class PokemonListViewModel {
    
    private var apiClient = ApiClient(baseUrl: API.ImageUrl)
    private let dataManager = DataManager(baseUrl: API.BaseUrl)
    
    func getPokemons(_ completion: @escaping PokemonListCompletion) {
        dataManager.getData(endpoint: API.PokemonsEndpoint, [Pokemon].self) { (response, error) in
            guard let pokemonListFromResponse = response as! [Pokemon]? else {
                completion(nil)
                return
            }
            completion(pokemonListFromResponse)
        }
    }
    
    func getImageData(pokemonNumber: Int, completion: @escaping ImageDataCompletion) {
        apiClient.getImageData(pokemonNumber: String(describing: pokemonNumber)) { (data, error) in
            guard error == nil, data != nil else {
                completion(nil, .FailedRequest)
                return
            }
            completion(data, nil)
        }
    }
    
    func getTypes(_ completion: @escaping PokemonTypeListCompletion) {
        dataManager.getData(endpoint: API.PokemonTypesEndpoint, [PokemonType].self) { (response, error) in
            guard let typeListFromResponse = response as! [PokemonType]? else {
                completion(nil)
                return
            }
            completion(typeListFromResponse)
        }
    }
    
    func getDexNumberString(pokemonNumber: Int) -> String {
        var digitCount = pokemonNumber.numberOfDigits()
        var dexNumberString = "#"
        
        while digitCount < 3 {
            dexNumberString = "\(dexNumberString)0"
            digitCount += 1
        }
        dexNumberString = "\(dexNumberString)\(pokemonNumber)"
        return dexNumberString
    }
}
