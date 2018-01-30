//
//  CreateOrEditPokemonViewControllerSetupsExtension.swift
//  PokeClient
//
//  Created by Tiago Santos on 30/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

// MARK: - Setups
extension CreateOrEditPokemonViewController {
    internal func setupView() {
        setNavigationItemTitle()
        setTextFieldContents()
        setTypePickerView()
    }
    
    internal func setNavigationItemTitle() {
        guard pokemon != nil else {
            navigationBar.items?.first?.title = "New Pokémon"
            return
        }
        navigationBar.items?.first?.title = "Edit Pokémon"
    }
    
    internal func setTextFieldContents() {
        guard let pokemon = pokemon else { return }
        
        guard let pokemonNumber = pokemon.dexNumber else { return }
        guard let pokemonName = pokemon.name else { return }
        guard let pokemonHeight = pokemon.height else { return }
        guard let pokemonWeight = pokemon.weight else { return }
        guard let pokemonType = pokemon.type else { return }
        
        numberField.text = String(describing: pokemonNumber)
        nameField.text = String(describing: pokemonName)
        heightField.text = String(describing: pokemonHeight)
        weightField.text = String(describing: pokemonWeight)
        typeField.text = String(describing: pokemonType)
    }
    
    internal func setTypePickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        typeField.inputView = pickerView
    }
}
