//
//  ApiClient.swift
//  PokeClient
//
//  Created by Tiago Santos on 19/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation
import Result

typealias ResultCallback<Value> = (Result<Value, AnyError>) -> Void

protocol ApiClient {
    
    func send<T: ApiRequest>(_ request: T, completion: @escaping ResultCallback<T.Response>) -> Void
}
