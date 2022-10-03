//
//  MainTabBarController.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 03/10/2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabBarItems()
    }
    
    private func setUpTabBarItems() {
        let charactersNavigationController = UIStoryboard(name: "Characters", bundle: nil)
            .instantiateInitialViewController() as! UINavigationController
        let charactersTabBarItem = UITabBarItem(title: "Characters", image: nil, selectedImage: nil)
        charactersNavigationController.tabBarItem = charactersTabBarItem
        setViewControllers([charactersNavigationController], animated: false)
        selectedIndex = TabIndex.characters.rawValue
    }
    
    private enum TabIndex: Int {
        case characters = 0
    }
}
