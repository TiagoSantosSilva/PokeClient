//
//  PokemonListViewController.swift
//  PokeClient
//
//  Created by Tiago Santos on 21/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension PokemonListViewController {
    func setupNavigationBar() {
        navigationItem.title = "Pokémons"
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9732790589, green: 0.355466038, blue: 0.3788164854, alpha: 1)
    }
}
