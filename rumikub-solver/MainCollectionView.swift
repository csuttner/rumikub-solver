//
//  ViewController.swift
//  rumikub-solver
//
//  Created by Clay Suttner on 4/8/20.
//  Copyright © 2020 skite. All rights reserved.
//

import UIKit

let MainTileCellID = "Main Tile Cell ID"

class MainCollectionView: UICollectionViewController {
    
    let tileManager = TileManager()
    let solver = TileSolver()
    let drawButton = MainButton(self, action: #selector(drawTile), title: "Draw Tile")
    let clearButton = MainButton(self, action: #selector(clear), title: "Clear Tiles")
    let solveButton = MainButton(self, action: #selector(solve), title: "Solve Set")
    
    lazy var tileWidth = (view.frame.width / 13) - 1
    
    lazy var buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 25
        stack.distribution = .fillEqually
        stack.addArrangedSubview(drawButton)
        stack.addArrangedSubview(clearButton)
        stack.addArrangedSubview(solveButton)
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(TileCell.self, forCellWithReuseIdentifier: MainTileCellID)
        
        let safe = view.safeAreaLayoutGuide
        
        view.addSubview(buttonStack)
        buttonStack.anchor(top: safe.topAnchor, left: safe.leftAnchor, bottom: collectionView.topAnchor, right: safe.rightAnchor, paddingTop: 25, paddingLeft: 25, paddingBottom: 25, paddingRight: 25)
        
        collectionView.anchor(top: safe.topAnchor, left: safe.leftAnchor, bottom: safe.bottomAnchor, right: safe.rightAnchor, paddingTop: tileWidth)
    }
    
    @objc func drawTile() {
        tileManager.drawRandom()
        collectionView.reloadData()
    }
    
    @objc func clear() {
        tileManager.resetPool()
        collectionView.reloadData()
        drawButton.isEnabled = true
    }
    
    @objc func solve() {
        drawButton.isEnabled = false
        let answer = solver.determineSets(population: tileManager.table)
        let answerView = AnswerView(answer: answer)
        present(answerView, animated: true, completion: nil)
    }

}

// Collection View Delegate / Datasoure
extension MainCollectionView {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tileManager.table.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainTileCellID, for: indexPath) as! TileCell
        cell.configureCell(for: tileManager.table[indexPath.row])
        return cell
    }
    
}

extension MainCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: tileWidth, height: tileWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
}

class MainButton: UIButton {
    
    init(_ target: Any?, action: Selector, title: String) {
        super.init(frame: CGRect())
        backgroundColor = .darkGray
        tintColor = .white
        setTitle(title, for: .normal)
        
        if let titleLabel = titleLabel {
            titleLabel.sizeToFit()
            titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
            layer.cornerRadius = titleLabel.frame.height / 2
        }
        
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
