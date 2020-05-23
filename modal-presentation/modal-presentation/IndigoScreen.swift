//
//  ViewController.swift
//  modal-presentation
//
//  Created by Clay Suttner on 4/28/20.
//  Copyright © 2020 skite. All rights reserved.
//

import UIKit

class IndigoScreen: UIViewController {

    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemIndigo
        setUpButton()
    }

    func setUpButton() {
        button.setTitle("Go to Teal Screen", for: .normal)
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
        let tealScreen = TealScreen()
        tealScreen.title = "Teal Screen"
        
        navigationController?.pushViewController(tealScreen, animated: true)
    }

}

