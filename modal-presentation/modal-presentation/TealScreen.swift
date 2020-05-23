//
//  TealScreen.swift
//  modal-presentation
//
//  Created by Clay Suttner on 4/28/20.
//  Copyright © 2020 skite. All rights reserved.
//

import Foundation
import UIKit

class TealScreen: UIViewController {
    
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setUpButton()
    }
    
    func setUpButton() {
        button.setTitle("Go Back", for: .normal)
        button.tintColor = .white
        view.addSubview(button)
        setUpButtonConstraints()
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func setUpButtonConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func buttonTapped() {
        present(IndigoScreen(), animated: true, completion: nil)
    }

    
}
