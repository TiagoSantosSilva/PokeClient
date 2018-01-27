//
//  LoadingScreenViewModel.swift
//  PokeClient
//
//  Created by Tiago Santos on 27/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

class LoadingScreenViewModel {
    
    private var dataManager: DataManager<Status>!
    internal var loadingScreenViewController: LoadingScreenViewController!
    
    init(loadingScreenViewController: LoadingScreenViewController) {
        self.loadingScreenViewController = loadingScreenViewController
        self.dataManager = DataManager<Status>(baseUrl: API.BaseUrl)
    }
    
    func getStatusData() {
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
            self.loadingScreenViewController.present(navigationController, animated: true, completion: nil)
        }
    }
}
