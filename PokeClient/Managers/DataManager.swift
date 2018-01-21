//
//  DataManager.swift
//  PokeClient
//
//  Created by Tiago Santos on 19/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

typealias DataCompletion = (AnyObject?, DataManagerError?) -> ()

final class DataManager<T: Codable> {
    
    let baseUrl: URL
    
    init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }
    
    func getData(endpoint: String, completion: @escaping DataCompletion) {
        
        let requestUrl = baseUrl.appendingPathComponent(endpoint)
        
        URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
            self.didFetchData(data: data, response: response, error: error, completion: completion)
        }.resume()
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
        guard let dataDecoded = try? JSONDecoder().decode(T.self, from: data) as AnyObject else {
            guard let dataDecoded = try? JSONDecoder().decode([T].self, from: data) as AnyObject else {
                completion(nil, .InvalidResponse)
                return
            }
            completion(dataDecoded, nil)
            return
        }
        
        completion(dataDecoded, nil)
        return
    }
}
