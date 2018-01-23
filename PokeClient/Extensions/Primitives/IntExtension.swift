//
//  IntExtension.swift
//  PokeClient
//
//  Created by Tiago Santos on 23/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

extension Int {
    func numberOfDigits() -> Int {
        var integer = self
        var digitCount = 0
        
        while integer >= 1 {
            digitCount += 1
            integer /= 10
        }
        
        return digitCount
    }
}
