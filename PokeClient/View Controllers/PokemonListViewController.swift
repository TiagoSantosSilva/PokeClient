//
//  ViewController.swift
//  PokeClient
//
//  Created by Tiago Santos on 19/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    private let dataManager = DataManager<Pokemon>(baseUrl: API.BaseUrl)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.getData(endpoint: API.PokemonEndpoint) { (response, error) in
            print(response ?? "🤯")
        }
    }
}

