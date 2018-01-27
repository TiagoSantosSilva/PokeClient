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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingScreenViewModel = LoadingScreenViewModel(loadingScreenViewController: self)
        getStatusData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    internal func getStatusData() {
        loadingScreenViewModel.getStatusData()
    }
}
