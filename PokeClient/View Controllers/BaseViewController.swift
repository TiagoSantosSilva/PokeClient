//
//  BaseViewController.swift
//  PokeClient
//
//  Created by Tiago Santos on 28/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit
import Reachability

class BaseViewController: UIViewController {
    
    internal var reachability: Reachability!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNotifier()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserver()
    }
}

extension BaseViewController: ReachabilityManager {
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
