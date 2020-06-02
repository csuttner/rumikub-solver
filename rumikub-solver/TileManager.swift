//
//  TileManager.swift
//  rumikub-solver
//
//  Created by Clay Suttner on 4/8/20.
//  Copyright © 2020 skite. All rights reserved.
//

import Foundation
import UIKit

enum TileLocation {
    case pool
    case rack
    case table
}

class TileManager {
    
    var pool: Set<Tile>
    var rack: Set<Tile>
    var table: Set<Tile>
    
    init() {
        var allTiles: Set<Tile> = []
        let colors: [String: UIColor] = ["T": .systemTeal, "B": .black, "R": .red, "O": .orange]
        
        for number in 1...13 {
            for color in colors {
                let symbol = color.key + String(format: "%02d", number)
                allTiles.insert(Tile(symbol: symbol, number: number, color: color.value, copy: .first))
                allTiles.insert(Tile(symbol: symbol, number: number, color: color.value, copy: .second))
            }
        }
        
        self.pool = allTiles
        self.rack = []
        self.table = []
    }
    
    func printTileLocation(_ tileLocation: TileLocation) {
        
        let locationToPrint: Set<Tile>
        
        switch tileLocation {
        case .pool:
            locationToPrint = pool
        case .rack:
            locationToPrint = rack
        case .table:
            locationToPrint = table
        }
        
        for tile in locationToPrint {
            print(tile.symbol)
        }
    }
    
    func drawRandom() -> Tile? {
        if let randomTile = pool.randomElement() {
            rack.insert(randomTile)
            pool.remove(randomTile)
            return randomTile
        } else {
            print("No tiles left in pool")
            return nil
        }
        
    }
    
    func resetPool() {
        while rack.count > 0 {
            if let randomTile = rack.randomElement() {
                rack.remove(randomTile)
                pool.insert(randomTile)
            }
        }
    }
}
