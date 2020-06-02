//
//  TileSolver.swift
//  rumikub-solver
//
//  Created by Clay Suttner on 4/8/20.
//  Copyright © 2020 skite. All rights reserved.
//

import Foundation
import UIKit

class TileSolver {
    
    static func determineSets(population: [Tile]) -> [[Tile]] {
        
        let reds = population.filter { (tile) -> Bool in
            return tile.color == .red
        }
        
        let teals = population.filter { (tile) -> Bool in
            return tile.color == .systemTeal
        }
        
        let oranges = population.filter { (tile) -> Bool in
            return tile.color == .orange
        }
        
        let blacks = population.filter { (tile) -> Bool in
            return tile.color == .black
        }
        
        return [teals, blacks, reds, oranges]
    }
    
}
