//
//  NewPokemonViewControllerReachabilityExtension.swift
//  PokeClient
//
//  Created by Tiago Santos on 27/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation
import Reachability

extension NewPokemonViewController: ReachabilityManager {
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged), name: .reachabilityChanged, object: reachability)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
    func startNotifier() {
        reachability = Reachability()
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Could not start reachability notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .none:
            print("Network not reachable")
            let noConnectionViewController = NoConnectionViewController(reachability: reachability)
            present(noConnectionViewController, animated: true, completion: nil)
        default:
            return
        }
    }
}
