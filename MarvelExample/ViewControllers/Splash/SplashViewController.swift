//
//  SplashViewController.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 03/10/2022.
//

import UIKit
import FirebaseAuthUI

class SplashViewController: UIViewController {
    
    private var shouldCheckForToken = true

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkForToken()
    }
    
    private func checkForToken() {
        guard shouldCheckForToken else {
            return
        }
        shouldCheckForToken.toggle()
        if KeychainManager.getString(key: .token) == nil {
            presentAuthenticationViewController()
        } else {
            presentMainTabBarController()
        }
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
        shouldCheckForToken = true
    }
}

extension SplashViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        authDataResult?.user.getIDToken { token, error in
            guard let token = token else { return }
            KeychainManager.save(key: .token, string: token)
        }
        DispatchQueue.main.async { [weak self] in
            guard error == nil else {
                self?.presentAuthenticationViewController()
                return
            }
            self?.presentMainTabBarController()
        }
    }
}

