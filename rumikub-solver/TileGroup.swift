//
//  TileGroup.swift
//  rumikub-solver
//
//  Created by Clay Suttner on 6/5/20.
//  Copyright © 2020 skite. All rights reserved.
//

import Foundation
import UIKit

class TileSet: Equatable {
    let number: Int
    var colors = Set<UIColor>()
    var tiles = [Tile]()
    
    init(tile: Tile) {
        number = tile.number
        colors.insert(tile.color)
        tiles.append(tile)
    }
    
    init(tiles: [Tile], number: Int) {
        self.number = number
        self.tiles.append(contentsOf: tiles)
        
        var colors = Set<UIColor>()
        for tile in tiles {
            colors.insert(tile.color)
        }
        
        self.colors = colors
    }
    
    func printTiles() {
        for tile in tiles {
            print(tile.symbol)
        }
    }
}

func ==(lhs: TileSet, rhs: TileSet) -> Bool {
    return lhs.tiles == rhs.tiles
}

class TileRun {
    let color: UIColor
    var first: Int
    var last: Int
    var tiles = [Tile]()
    
    init(tile: Tile) {
        color = tile.color
        first = tile.number
        last = tile.number
        tiles.append(tile)
    }
    
    func printTiles() {
        for tile in tiles {
            print(tile.symbol)
        }
    }
}

class TileGroup: Equatable {
    var population: [Tile]
    var sets = [TileSet]()
    var runs = [TileRun]()
    
    init(population: [Tile]) {
        self.population = population
    }
    
    private init(population: [Tile], sets: [TileSet], runs: [TileRun]) {
        self.population = population
        self.sets = sets
        self.runs = runs
    }
    
    func getSetCandidates(for number: Int) -> [TileSet]? {
        let matches = population.filter { (tile) -> Bool in
            return tile.number == number
        }
        
        if matches.count < 3 {
            return nil
        }
        
        var colors = Set<UIColor>()
        for match in matches {
            colors.insert(match.color)
        }
        
        if colors.count < 3 {
            return nil
        }
        
        if colors.count == 3 {
            var tiles = [Tile]()
            for color in colors {
                tiles.append(Tile(number: number, color: color))
            }
            return [TileSet(tiles: tiles, number: number)]
        }
        
        // nust be four colors
        
        return setPossibilities(for: number)
        
    }
    
    func setPossibilities(for number: Int) -> [TileSet] {
        var tileSets = [TileSet]()
        
        let t = Tile(number: number, color: .systemTeal)
        let r = Tile(number: number, color: .red)
        let b = Tile(number: number, color: .black)
        let o = Tile(number: number, color: .orange)
        
        tileSets.append(TileSet(tiles: [t, b, r, o], number: number))
        tileSets.append(TileSet(tiles: [t, b, r], number: number))
        tileSets.append(TileSet(tiles: [t, b, o], number: number))
        tileSets.append(TileSet(tiles: [t, r, o], number: number))
        tileSets.append(TileSet(tiles: [b, r, o], number: number))
        
        return tileSets
    }
    
    func pullSet(tileSet: TileSet) {
        sets.append(tileSet)
        for tile in tileSet.tiles {
            if let tileIndex = population.firstIndex(of: tile) {
                population.remove(at: tileIndex)
            }
        }
    }
    
    func getScore() -> Int {
        var score = 0
        for set in sets {
            score = score + set.tiles.count
        }
        return score
    }
    
    func printSets() {
        var counter = 0
        for set in sets {
            print("Set #\(counter)")
            set.printTiles()
            counter += 1
        }
    }
    
    func printPopulation() {
        for tile in population {
            print(tile.symbol)
        }
    }
    
    func copy() -> TileGroup {
        return TileGroup(population: population, sets: sets, runs: runs)
    }
}

func ==(lhs: TileGroup, rhs: TileGroup) -> Bool {
    return lhs.population == rhs.population && lhs.sets == rhs.sets
}
