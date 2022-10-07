//
//  FirebaseAuthManager.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 07/10/2022.
//

import Foundation
import FirebaseCore
import FirebaseAuthUI
import FirebaseEmailAuthUI

class FirebaseAuthManager {
    
    static let shared = FirebaseAuthManager()
    
    private let authUI: FUIAuth?
    
    private init() {
        FirebaseApp.configure()
        authUI = FUIAuth.defaultAuthUI()
        let providers: [FUIAuthProvider] = [
          FUIEmailAuth()
        ]
        authUI?.providers = providers
        authUI?.shouldHideCancelButton = true
    }
    
    func getAuthenticationViewController(delegate: FUIAuthDelegate) -> UIViewController? {
        authUI?.delegate = delegate
        return authUI?.authViewController()
    }
}
