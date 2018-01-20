//
//  ApiRequest.swift
//  PokeClient
//
//  Created by Tiago Santos on 19/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

protocol ApiRequest: Encodable {
    
    associatedtype Response: Decodable
    
    var resourceName: String { get }
}
