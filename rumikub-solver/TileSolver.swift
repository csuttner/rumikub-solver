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
    
    let memo = [Tile]()
    
    func determineSets(population: [Tile]) -> [[Tile]]? {
        var pop = population
        if let randomElement = population.randomElement(), let index = pop.firstIndex(of: randomElement) {
            pop.remove(at: index)
            return bruteForce(candidate: [randomElement], population: pop)
        }
        return nil
    }
    
    func bruteForce(candidate: [Tile], population: [Tile]) -> [[Tile]] {
        var cand = candidate
        var pop = population
        var colors = [UIColor]()
        for item in cand {
            colors.append(item.color)
        }
        if let first = cand.first {
            print(first.number)
            let match = pop.first { (tile) -> Bool in
                return tile.number == first.number && !colors.contains(tile.color)
            }
            if let match = match {
                cand.append(match)
                if let index = pop.firstIndex(of: match) {
                    pop.remove(at: index)
                }
            }
        }
        return [cand, pop]
    }
    
    func orderByColor(population: [Tile]) -> [[Tile]] {
        
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
