//
//  LoadingScreenViewModel.swift
//  PokeClient
//
//  Created by Tiago Santos on 27/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

class LoadingScreenViewModel {
    
    private var dataManager: DataManager!
    
    init(loadingScreenViewController: LoadingScreenViewController) {
        self.dataManager = DataManager(baseUrl: API.BaseUrl)
    }
    
    func getStatusData(_ completion: @escaping BooleanCompletion) {
        dataManager.getData(endpoint: API.StatusEndpoint, Status.self) { (response, error) in
            guard error == nil, let status = response as? Status, status.code == 200 else {
                completion(false)
                return
            }
            completion(true)
        }
    }
}
