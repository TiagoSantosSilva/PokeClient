//
//  PokemonListViewModel.swift
//  PokeClient
//
//  Created by Tiago Santos on 28/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

typealias PokemonListCompletion = ([Pokemon]?) -> ()

class PokemonListViewModel {
    
    internal var apiClient = ApiClient(baseUrl: API.ImageUrl)
    internal let dataManager = DataManager<Pokemon>(baseUrl: API.BaseUrl)
    
    
    func getData(_ completion: @escaping PokemonListCompletion) {
        dataManager.getData(endpoint: API.PokemonEndpoint) { (response, error) in
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
}
