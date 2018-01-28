//
//  BaseViewModel.swift
//  PokeClient
//
//  Created by Tiago Santos on 28/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

typealias TypeListCompletion = ([String]?) -> ()

class BaseViewModel {
    
    private let dataManager = DataManager(baseUrl: API.BaseUrl)
    
    func getTypes(_ completion: @escaping TypeListCompletion) {
//        dataManager.getData<Pokemon>(endpoint: API.TypesEndpoint, Pokemon.self) { (response, error) in
//            guard let typeListFromResponse = response as! [String]? else {
//                completion(nil)
//                return
//            }
//            completion(typeListFromResponse)
//        }
    }
}
