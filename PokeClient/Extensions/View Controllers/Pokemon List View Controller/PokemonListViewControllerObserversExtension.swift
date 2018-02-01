//
//  PokemonListViewControllerObserversExtension.swift
//  PokeClient
//
//  Created by Tiago Santos on 01/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

extension PokemonListViewController {
    internal func addObservers() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("openUrl"), object: nil)
    }
    
    internal func removeObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(urlOpened), name: Notification.Name("openUrl"), object: nil)
    }
}
