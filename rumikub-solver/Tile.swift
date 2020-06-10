//
//  Tile.swift
//  rumikub-solver
//
//  Created by Clay Suttner on 4/8/20.
//  Copyright © 2020 skite. All rights reserved.
//

import Foundation
import UIKit

class Tile: Equatable {
    
    let number: Int
    let color: UIColor
    let symbol: String
    
    init(number: Int, color: UIColor) {
        self.number = number
        self.color = color
        self.symbol = rkColors[color]! + String(number)
    }
    
}

func ==(lhs: Tile, rhs: Tile) -> Bool {
    return lhs.color == rhs.color && lhs.number == rhs.number
}
