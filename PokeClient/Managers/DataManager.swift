//
//  DataManager.swift
//  PokeClient
//
//  Created by Tiago Santos on 19/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

enum DataManagerError: Error {
    case Unknown
    case FailedRequest
    case InvalidResponse
}

final class DataManager {
    
    typealias StatusDataCompletion = (AnyObject?, DataManagerError?) -> ()
    
    let baseUrl: URL
    
    init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }
    
    func statusData(completion: @escaping StatusDataCompletion) {
        let URL = baseUrl.appendingPathComponent("Status")
        
        URLSession.shared.dataTask(with: URL) { (data, response, error) in
            self.didFetchStatusData(data: data, response: response, error: error, completion: completion)
        }.resume()
    }
    
    func pokemonData() {
        // let URL = baseUrl.appendingPathComponent("Pokemons")
    }
    
    func pokemonDataForId(id: String) {
        // let URL = baseUrl.appendingPathComponent("Pokemons/\(id)")
    }
    
    private func didFetchStatusData(data: Data?, response: URLResponse?, error: Error?, completion: StatusDataCompletion) {
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
        
        processStatusData(data: data, completion: completion)
    }
    
    private func processStatusData(data: Data, completion: StatusDataCompletion) {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as AnyObject else {
            completion(nil, .InvalidResponse)
            return
        }
        
        completion(json, nil)
    }
}
