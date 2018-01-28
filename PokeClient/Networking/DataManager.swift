//
//  DataManager.swift
//  PokeClient
//
//  Created by Tiago Santos on 19/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

typealias DataCompletion = (AnyObject?, DataManagerError?) -> ()

final class DataManager {
    
    let baseUrl: URL
    
    init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }
    
    func getData<T: Codable>(endpoint: String, _ type: T.Type, completion: @escaping DataCompletion) {
        
        let requestUrl = baseUrl.appendingPathComponent(endpoint)
        
        URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
            self.didFetchData(data: data, response: response, error: error, T.self, completion: completion)
            }.resume()
    }
    
    
    private func didFetchData<T: Codable>(data: Data?, response: URLResponse?, error: Error?, _ type: T.Type, completion: DataCompletion) {
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
        
        processData(data: data, T.self, completion: completion)
    }
    
    private func processData<T: Codable>(data: Data, _ type: T.Type, completion: DataCompletion) {
        guard let dataDecoded = try? JSONDecoder().decode(T.self, from: data) as AnyObject else {
            completion(nil, .InvalidResponse)
            return
        }
        
        completion(dataDecoded, nil)
        return
    }
    
    func postData<T: Codable>(endpoint: String, data: Data, method: String, _ type: T.Type, completion: @escaping DataCompletion) {
        let requestUrl = baseUrl.appendingPathComponent(endpoint)
        
        var request = URLRequest(url: requestUrl)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = method
        request.httpBody = data
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil, let data = data else {
                completion(nil, .FailedRequest)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 201 else {
                completion(nil, .InvalidResponse)
                return
            }
            
            self.processData(data: data, T.self, completion: completion)
            
            }.resume()
    }
}
