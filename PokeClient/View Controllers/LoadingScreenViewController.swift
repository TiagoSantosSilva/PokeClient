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
        
        dataManager.getData(endpoint: API.StatusEndpoint) { (response, error) in
            guard let status = response as? Status else {
                // Throw alert controller -> Retry
                return
            }
            print(status)
        }
    }
}
