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
    
    // memo
    var groups = [TileGroup]()
    var recursiveCalls = 0
    
    func determineSets(population: [Tile]) -> TileGroup {
        let group = TileGroup(population: population)
        getSets(group: group)
        let solution = bestSolution(from: groups)
        
//        var counter = 0
//        for group in groups {
//            print("group #: \(counter)")
//
//            print("population:")
//            group.printPopulation()
//
//            print("sets:")
//            group.printSets()
//
//            counter += 1
//            print("\n")
//        }
        
        print(recursiveCalls)
        recursiveCalls = 0
        self.groups = [TileGroup]()
        return solution
    }
    
    func getSets(group: TileGroup) {
        
        // stop condition - if nil then population is empty
        if let firstNumber = group.population.first?.number {

            // if there are candidates for sets of this number in the population
            if let setCandidates = group.getSetCandidates(for: firstNumber) {
                for candidate in setCandidates {
                    let newGroup = group.copy()
                    newGroup.pullSet(tileSet: candidate)
                    recursiveCalls += 1
                    getSets(group: newGroup)
                }
            } else {
                // there are no candidates, remove this tile from the population and recurse
                let newGroup = group.copy()
                newGroup.population.remove(at: 0)
                recursiveCalls += 1
                getSets(group: newGroup)
            }
        }
        groups.append(group)
    }
    
    func bestSolution(from groups: [TileGroup]) -> TileGroup {
        var highScore = 0
        var best = TileGroup(population: [Tile]())
        for group in groups {
            if group.getScore() >= highScore {
                highScore = group.getScore()
                best = group
            }
        }
        return best
    }
    
}
