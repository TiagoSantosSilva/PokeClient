//
//  NoConnectionViewController.swift
//  PokeClient
//
//  Created by Tiago Santos on 27/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit
import Reachability

class NoConnectionViewController: UIViewController {

    private var reachability: Reachability!
    
    convenience init(reachability: Reachability) {
        self.init()
        self.reachability = reachability
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged), name: .reachabilityChanged, object: reachability)
    }
    
    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi, .cellular:
            NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
            dismiss(animated: true, completion: nil)
        case .none:
            return
        }
    }
}
