//
//  ApiClient.swift
//  PokeClient
//
//  Created by Tiago Santos on 23/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

typealias ImageDataCompletion = (Data?, DataManagerError?) -> ()

class ApiClient {
    let baseUrl: URL
    
    init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }
    
    func getImageData(pokemonNumber: String, completion: @escaping ImageDataCompletion) {
        
        guard let url = setImageRequestUrl(pokemonNumber: pokemonNumber) else {
            completion(nil, nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(nil, .InvalidResponse)
                return
            }
            
            completion(data, nil)
        }.resume()
    }
    
    func setImageRequestUrl(pokemonNumber: String) -> URL? {
        var baseUri = self.baseUrl.absoluteString
        baseUri = baseUri.replacingOccurrences(of: "pokemon_id", with: pokemonNumber)
        return URL(string: baseUri)!
    }
}
