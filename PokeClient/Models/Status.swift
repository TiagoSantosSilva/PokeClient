//
//  Status.swift
//  PokeClient
//
//  Created by Tiago Santos on 19/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

struct Status: Codable {
    let id: Int?
    let code: Int?
    let description: String?
    
    enum CodingKeys : String, CodingKey {
        case id = "Id"
        case code = "Code"
        case description = "Description"
    }
}
