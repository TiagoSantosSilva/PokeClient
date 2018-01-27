//
//  LoadingScreenViewController.swift
//  PokeClient
//
//  Created by Tiago Santos on 21/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

class LoadingScreenViewController: UIViewController {
    
    private let dataManager = DataManager<Status>(baseUrl: API.BaseUrl)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStatusData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    internal func getStatusData() {
        dataManager.getData(endpoint: API.StatusEndpoint) { (response, error) in
            guard let status = response as? Status else {
                self.presentNoConnectionAlertController()
                return
            }
            
            guard status.code == 200 else {
                self.presentServerNotUpAlertController()
                return
            }
            
            let pokemonListViewController = PokemonListViewController(nibName: "PokemonListViewController", bundle: nil)
            let navigationController = UINavigationController(rootViewController: pokemonListViewController)
            self.present(navigationController, animated: true, completion: nil)
        }
    }
}
