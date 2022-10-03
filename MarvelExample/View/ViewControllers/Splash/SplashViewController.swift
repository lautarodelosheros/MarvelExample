//
//  SplashViewController.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 03/10/2022.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentMainTabBarController()
    }
    
    private func presentMainTabBarController() {
        let mainTabBarController = MainTabBarController()
        mainTabBarController.modalPresentationStyle = .fullScreen
        mainTabBarController.modalTransitionStyle = .crossDissolve
        present(mainTabBarController, animated: true)
    }
}

