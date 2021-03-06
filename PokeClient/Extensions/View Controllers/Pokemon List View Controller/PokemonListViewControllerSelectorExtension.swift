//
//  PokemonListViewControllerSelectorExtension.swift
//  PokeClient
//
//  Created by Tiago Santos on 28/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

extension PokemonListViewController {
    @objc internal func newPokemonButtonTapped() {
        let newPokemonViewController = CreateOrEditPokemonViewController(pokemonTypes: pokemonTypes, pokemonListViewController: self)
        present(newPokemonViewController, animated: true, completion: nil)
    }
    
    @objc func urlOpened(notification: Notification) {
        print("Url opened")
    }
}
