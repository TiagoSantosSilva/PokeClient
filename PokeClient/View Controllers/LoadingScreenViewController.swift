//
//  LoadingScreenViewController.swift
//  PokeClient
//
//  Created by Tiago Santos on 21/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

class LoadingScreenViewController: UIViewController {
    
    private var loadingScreenViewModel: LoadingScreenViewModel!
    
    convenience init() {
        self.init()
        loadingScreenViewModel = LoadingScreenViewModel(loadingScreenViewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStatusData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    internal func getStatusData() {
    }
}
