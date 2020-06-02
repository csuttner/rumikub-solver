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

class AnswerCollectionView: UICollectionViewController {
    
    let answer: [[Tile]]
    
    lazy var tileWidth = (view.frame.width / 13) - 1
    
    init(collectionViewLayout layout: UICollectionViewLayout, answer: [[Tile]]) {
        self.answer = answer
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(TileCell.self, forCellWithReuseIdentifier: answerTileCellID)
    }
    
}

extension AnswerCollectionView {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return answer.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return answer[section].count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: answerTileCellID, for: indexPath) as! TileCell
        cell.configureCell(for: answer[indexPath.section][indexPath.row])
        return cell
    }
    
}

extension AnswerCollectionView: UICollectionViewDelegateFlowLayout {
    
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
