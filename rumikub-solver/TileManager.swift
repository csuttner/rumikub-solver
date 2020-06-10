//
//  TileManager.swift
//  rumikub-solver
//
//  Created by Clay Suttner on 4/8/20.
//  Copyright © 2020 skite. All rights reserved.
//

import Foundation
import UIKit

let rkColors: [UIColor: String] = [.systemTeal : "T", .red : "R", .black : "B", .orange : "O"]

class TileManager {
    
    var pool: [Tile]
    var table: [Tile]
    
    init() {
        var allTiles = [Tile]()
        
        for number in 1...13 {
            for color in rkColors {
                allTiles.append(Tile(number: number, color: color.key))
                allTiles.append(Tile(number: number, color: color.key))
            }
        }
        
        self.pool = allTiles
        self.table = []
    }
    
    init(scenario: [Tile]) {
        self.pool = scenario
        self.table = []
    }
    
    func drawRandom() {
        if let randomTile = pool.randomElement(), let tileIndex = pool.firstIndex(of: randomTile) {
            table.append(randomTile)
            pool.remove(at: tileIndex)
        } else {
            print("No tiles left in pool")
        }
    }
    
    func resetPool() {
        while table.count > 0 {
            if let randomTile = table.randomElement(), let tileIndex = table.firstIndex(of: randomTile) {
                table.remove(at: tileIndex)
                pool.append(randomTile)
            }
        }
    }
}
