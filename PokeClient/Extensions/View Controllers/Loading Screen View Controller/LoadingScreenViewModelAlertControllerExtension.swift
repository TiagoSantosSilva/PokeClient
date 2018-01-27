//
//  LoadingScreenViewControllerAlertControllerExtension.swift
//  PokeClient
//
//  Created by Tiago Santos on 22/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

extension LoadingScreenViewModel {
    internal func presentNoConnectionAlertController() {
        let noConnectionAlertController = UIAlertController(title: "No Connection", message: "You seem to have no connection to the internet. Please try connecting again.", preferredStyle: .alert)
        noConnectionAlertController.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (handler) in
            self.getStatusData()
        }))
        noConnectionAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        loadingScreenViewController.present(noConnectionAlertController, animated: true, completion: nil)
    }
    
    internal func presentServerNotUpAlertController() {
        let serverNotUpAlertController = UIAlertController(title: "Server down", message: "The server is down. Please try connecting again later.", preferredStyle: .alert)
        serverNotUpAlertController.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (handler) in
            self.getStatusData()
        }))
        serverNotUpAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        loadingScreenViewController.present(serverNotUpAlertController, animated: true, completion: nil)
    }
}
