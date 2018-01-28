//
//  API.swift
//  PokeClient
//
//  Created by Tiago Santos on 19/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

struct API {
    static let ImageUrl = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/pokemon_id.png")!
    static let BaseUrl = URL(string: "http://localhost:5000/api/")!
    static let StatusEndpoint = "status"
    static let PokemonsEndpoint = "pokemons"
    static let TypesEndpoint = "types"
}
