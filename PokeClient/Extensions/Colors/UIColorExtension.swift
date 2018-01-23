//
//  UIColorExtensio.swift
//  PokeClient
//
//  Created by Tiago Santos on 21/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let blackBackgroundColor = UIColor.rgb(red: 21, green: 22, blue: 33)
    static let lightRedBackgroundColor = UIColor.rgb(red: 222, green: 94, blue: 86)
    static let darkRedBackgroundColor = UIColor.rgb(red: 40, green: 50, blue: 55)
    static let darkBlueBackgroundColor = UIColor.rgb(red: 183, green: 55, blue: 49)
}

