//
//  MainNavigationController.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 06/10/2022.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
    }
    
    private func setUpNavigationBar() {
        navigationBar.isTranslucent = false
        navigationBar.tintColor = .white
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "Toolbar")
        appearance.titleTextAttributes = [
            .font: UIFont(name: "RobotoCondensed-Bold", size: 20) ?? UIFont.boldSystemFont(ofSize: 20),
            .foregroundColor: UIColor.white
        ]
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
    }
}
