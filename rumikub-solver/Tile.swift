//
//  Tile.swift
//  rumikub-solver
//
//  Created by Clay Suttner on 4/8/20.
//  Copyright © 2020 skite. All rights reserved.
//

import Foundation
import UIKit

struct Tile: Hashable {
    
    enum Copy {
        case first
        case second
    }
    
    let symbol: String
    let number: Int
    let color: UIColor
    let copy: Copy
    
    init(symbol: String, number: Int, color: UIColor, copy: Copy) {
        self.number = number
        self.color = color
        self.symbol = symbol
        self.copy = copy
    }
    
}
