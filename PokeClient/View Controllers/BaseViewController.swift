//
//  BaseViewController.swift
//  PokeClient
//
//  Created by Tiago Santos on 28/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit
import Reachability

class BaseViewController: UIViewController {
    
    internal var reachability: Reachability!
    internal var pokemonTypes: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNotifier()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserver()
    }
}
