//
//  Status.swift
//  PokeClient
//
//  Created by Tiago Santos on 19/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

public struct Status: Decodable {
    public let Id: Int?
    public let Code: Int?
    public let Description: String?
}
