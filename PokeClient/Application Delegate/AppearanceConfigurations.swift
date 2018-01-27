//
//  AppearanceConfigurations.swift
//  PokeClient
//
//  Created by Tiago Santos on 27/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

class AppearanceConfigurations {
    
    class func configureUITextFields() {
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search a pokémon", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
    }
}
