//
//  ViewController.swift
//  PokeClient
//
//  Created by Tiago Santos on 19/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let dataManager = DataManager(baseUrl: API.BaseUrl)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.statusData { (response, error) in
            print(response ?? "🤨")
        }
    }
}

