//
//  Type.swift
//  PokeClient
//
//  Created by Tiago Santos on 28/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

struct PokemonType: Codable {
    let id: Int?
    let type: String?
    
    enum CodingKeys : String, CodingKey {
        case id = "Id"
        case type = "Type"
    }
}
