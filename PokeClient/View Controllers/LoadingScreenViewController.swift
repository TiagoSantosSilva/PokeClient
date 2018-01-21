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
    
    fileprivate func getStatusData() {
        dataManager.getData(endpoint: API.StatusEndpoint) { (response, error) in
            guard let status = response as? Status else {
                self.presentNoConnectionAlertController()
                return
            }
            
            guard status.code == 200 else {
                self.presentServerNotUpAlertController()
                return
            }
            
            let pokemonListViewController = PokemonListViewController()
            self.present(pokemonListViewController, animated: true, completion: nil)
        }
    }
    
    fileprivate func presentNoConnectionAlertController() {
        let noConnectionAlertController = UIAlertController(title: "No Connection", message: "You seem to have no connection to the internet. Please try connecting again.", preferredStyle: .alert)
        noConnectionAlertController.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (handler) in
            self.getStatusData()
        }))
        noConnectionAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(noConnectionAlertController, animated: true, completion: nil)
    }
    
    func presentServerNotUpAlertController() {
        let serverNotUpAlertController = UIAlertController(title: "Server down", message: "The server is down. Please try connecting again later.", preferredStyle: .alert)
        serverNotUpAlertController.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (handler) in
            self.getStatusData()
        }))
        serverNotUpAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(serverNotUpAlertController, animated: true, completion: nil)
    }
}
