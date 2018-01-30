//
//  CreateOrEditPokemonViewControllerIBActionsExtension.swift
//  PokeClient
//
//  Created by Tiago Santos on 30/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

// MARK: - IBActions
extension CreateOrEditPokemonViewController {
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismissWithTransition()
    }
    
    @IBAction func okButtonTapped(_ sender: Any) {
        createOrEditPokemon()
    }
    
    internal func dismissWithTransition() {
        let transition = FadeTransition()
        view.window!.layer.add(transition, forKey: nil)
        dismiss(animated: false, completion: nil)
    }
}
