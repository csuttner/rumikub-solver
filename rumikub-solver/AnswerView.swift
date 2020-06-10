//
//  AnswerCollectionView.swift
//  rumikub-solver
//
//  Created by Clay Suttner on 6/1/20.
//  Copyright © 2020 skite. All rights reserved.
//

import Foundation
import UIKit

let answerTileCellID = "Answer Tile Cell ID"

class AnswerView: UIViewController {
    
    let answer: TileGroup
    let setsCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewFlowLayout())
    let runsCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewFlowLayout())
    lazy var tileWidth = (view.frame.width / 13) - 1
    
    init(answer: TileGroup) {
        self.answer = answer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionViews()
        setupCollectionViews()
    }
    
    func configureCollectionViews() {
        setsCollectionView.delegate = self
        runsCollectionView.delegate = self
        
        setsCollectionView.dataSource = self
        runsCollectionView.dataSource = self
        
        setsCollectionView.register(TileCell.self, forCellWithReuseIdentifier: answerTileCellID)
        runsCollectionView.register(TileCell.self, forCellWithReuseIdentifier: answerTileCellID)
    }
    
    func setupCollectionViews() {
//        let setsHeight = tileWidth * CGFloat(answer.sets.count)
//        let runsHeight = tileWidth * CGFloat(answer.runs.count)
        
        setsCollectionView.frame = view.frame
//        setsCollectionView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: setsHeight)
//        runsCollectionView.frame = CGRect(x: 0, y: setsHeight, width: view.frame.width, height: runsHeight)
        view.addSubview(setsCollectionView)
//        view.addSubview(runsCollectionView)
    }
    
}

extension AnswerView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == setsCollectionView {
            return answer.sets.count
        }
        if collectionView == runsCollectionView {
            return answer.runs.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == setsCollectionView {
            return answer.sets[section].tiles.count
        }
        if collectionView == runsCollectionView {
            return answer.runs[section].tiles.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: answerTileCellID, for: indexPath) as! TileCell
        var tile: Tile

        if collectionView == setsCollectionView {
            tile = answer.sets[indexPath.section].tiles[indexPath.row]
            cell.configureCell(for: tile)
        }
        if collectionView == runsCollectionView {
            tile = answer.runs[indexPath.section].tiles[indexPath.row]
            cell.configureCell(for: tile)
        }
        
        return cell
    }
    
}

extension AnswerView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: tileWidth, height: tileWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}
