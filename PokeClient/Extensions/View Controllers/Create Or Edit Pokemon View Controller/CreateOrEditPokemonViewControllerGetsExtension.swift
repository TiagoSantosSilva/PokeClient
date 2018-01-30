//
//  CreateOrEditPokemonViewControllerGetsExtension.swift
//  PokeClient
//
//  Created by Tiago Santos on 30/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

// MARK: - Gets
extension CreateOrEditPokemonViewController {
    internal func getPokemonInViewData() -> Pokemon? {
        guard let number = numberField.text else { return nil }
        guard let name = nameField.text else { return nil }
        guard let height = heightField.text else { return nil }
        guard let weight = weightField.text else { return nil }
        guard let type = typeField.text else { return nil }
        
        let pokemonToReturn = Pokemon(id: pokemon?.id, dexNumber: Int(number), name: name, height: Float(height), weight: Float(weight), type: type)
        return pokemonToReturn
    }
}
