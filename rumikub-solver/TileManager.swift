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
    case table
}

class TileManager {
    
    var pool: [Tile]
    var table: [Tile]
    
    init() {
        var allTiles = [Tile]()
        let colors: [String: UIColor] = ["T": .systemTeal, "B": .black, "R": .red, "O": .orange]
        
        for number in 1...13 {
            for color in colors {
                let symbol = color.key + String(format: "%02d", number)
                allTiles.append(Tile(symbol: symbol, number: number, color: color.value, copy: .first))
                allTiles.append(Tile(symbol: symbol, number: number, color: color.value, copy: .second))
            }
        }
        
        self.pool = allTiles
        self.table = []
    }
    
    func printTileLocation(_ tileLocation: TileLocation) {
        
        let locationToPrint: [Tile]
        
        switch tileLocation {
        case .pool:
            locationToPrint = pool
        case .table:
            locationToPrint = table
        }
        
        for tile in locationToPrint {
            print(tile.symbol)
        }
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
