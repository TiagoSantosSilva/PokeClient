//
//  ReachabilityManager.swift
//  PokeClient
//
//  Created by Tiago Santos on 27/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

protocol ReachabilityManager {
    func addObserver()
    func removeObserver()
    func startNotifier()
}
