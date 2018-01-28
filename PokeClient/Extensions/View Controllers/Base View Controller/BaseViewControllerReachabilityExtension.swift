//
//  BaseViewControllerReachabilityExtension.swift
//  PokeClient
//
//  Created by Tiago Santos on 28/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation
import Reachability

extension BaseViewController: ReachabilityManager {
    internal func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged), name: .reachabilityChanged, object: reachability)
    }
    
    internal func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
    internal func startNotifier() {
        reachability = Reachability()
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Could not start reachability notifier")
        }
    }
    
    @objc internal func reachabilityChanged(note: Notification) {
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
