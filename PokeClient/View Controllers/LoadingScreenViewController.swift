//
//  LoadingScreenViewController.swift
//  PokeClient
//
//  Created by Tiago Santos on 21/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

typealias BooleanCompletion = (Bool) -> ()

class LoadingScreenViewController: BaseViewController {
    
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
        loadingScreenViewModel.getStatusData { (readyToStart) in
            guard readyToStart else {
                self.presentServerNotUpAlertController()
                return
            }
            
            let pokemonListViewController = PokemonListViewController(nibName: "PokemonListViewController", bundle: nil)
            let navigationController = UINavigationController(rootViewController: pokemonListViewController)
            self.present(navigationController, animated: true, completion: nil)
        }
    }
}
