//
//  Pokemon.swift
//  PokeClient
//
//  Created by Tiago Santos on 21/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let id: Int?
    let dexNumber: Int?
    let name: String?
    let height: Float?
    let weight: Float?
    
    enum CodingKeys : String, CodingKey {
        case id = "Id"
        case dexNumber = "DexNumber"
        case name = "Name"
        case height = "Height"
        case weight = "Weight"
    }
}
