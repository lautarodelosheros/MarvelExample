//
//  SplashViewController.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 03/10/2022.
//

import UIKit
import FirebaseAuthUI

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentAuthenticationViewController()
    }
    
    private func presentAuthenticationViewController() {
        guard let authenticationViewController = FirebaseAuthManager.shared.getAuthenticationViewController(delegate: self) else {
            return
        }
        authenticationViewController.modalTransitionStyle = .crossDissolve
        authenticationViewController.modalPresentationStyle = .fullScreen
        present(authenticationViewController, animated: true)
    }
    
    private func presentMainTabBarController() {
        let mainTabBarController = MainTabBarController()
        mainTabBarController.modalPresentationStyle = .fullScreen
        mainTabBarController.modalTransitionStyle = .crossDissolve
        present(mainTabBarController, animated: true)
    }
}

extension SplashViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        guard error == nil else {
            presentAuthenticationViewController()
            return
        }
        presentMainTabBarController()
    }
}

