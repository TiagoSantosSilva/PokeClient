//
//  DataManager.swift
//  PokeClient
//
//  Created by Tiago Santos on 19/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

final class DataManager {
    
    typealias DataCompletion = (AnyObject?, DataManagerError?) -> ()
    
    let baseUrl: URL
    
    init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }
    
    func statusData(completion: @escaping DataCompletion) {
        let URL = baseUrl.appendingPathComponent("Status")
        
        URLSession.shared.dataTask(with: URL) { (data, response, error) in
            self.didFetchData(data: data, response: response, error: error, completion: completion)
        }.resume()
    }
    
    func pokemonData() {
        // let URL = baseUrl.appendingPathComponent("Pokemons")
    }
    
    func pokemonDataForId(id: String) {
        // let URL = baseUrl.appendingPathComponent("Pokemons/\(id)")
    }
    
    private func didFetchData(data: Data?, response: URLResponse?, error: Error?, completion: DataCompletion) {
        guard error == nil else {
            completion(nil, .FailedRequest)
            return
        }
        
        guard let data = data, let response = response as? HTTPURLResponse
            else {
                completion(nil, .Unknown)
                return
        }
        
        guard response.statusCode == 200 else {
            completion(nil, .FailedRequest)
            return
        }
        
        processData(data: data, completion: completion)
    }
    
    private func processData(data: Data, completion: DataCompletion) {
        guard let data = try? JSONDecoder().decode([Status].self, from: data) as AnyObject else {
            completion(nil, .InvalidResponse)
            return
        }
        
        completion(data, nil)
    }
}
