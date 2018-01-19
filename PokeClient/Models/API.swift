//
//  API.swift
//  PokeClient
//
//  Created by Tiago Santos on 19/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

struct API {
    static let BaseUrl = URL(string: "http://localhost:5000/api/")!
    static let StatusEndpoint = URL(string: "status")!
    static let PokemonEndpoint = URL(string: "pokemon")!
}
