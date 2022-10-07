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
        setupTabBarStyle()
        setUpTabBarItems()
    }
    
    private func setupTabBarStyle() {
        tabBar.unselectedItemTintColor = UIColor(named: "Toolbar")
        tabBar.tintColor = UIColor(named: "Toolbar")
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        let textAttributes: [NSAttributedString.Key : Any] = [
            .font: UIFont(name: "Roboto-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor(named: "Toolbar") ?? .black,
            .paragraphStyle: NSParagraphStyle.default
        ]
        appearance.inlineLayoutAppearance.normal.titleTextAttributes = textAttributes
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = textAttributes
        appearance.compactInlineLayoutAppearance.normal.titleTextAttributes = textAttributes
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
    }
    
    private func setUpTabBarItems() {
        let charactersNavigationController = UIStoryboard(name: "Characters", bundle: nil)
            .instantiateInitialViewController() as! UINavigationController
        let charactersTabBarItem = UITabBarItem(
            title: "Characters",
            image: UIImage(named: "SuperheroUnselected"),
            selectedImage: UIImage(named: "SuperheroSelected")
        )
        charactersNavigationController.tabBarItem = charactersTabBarItem
        
        let eventsNavigationController = UIStoryboard(name: "Events", bundle: nil)
            .instantiateInitialViewController() as! UINavigationController
        let eventsTabBarItem = UITabBarItem(
            title: "Events",
            image: UIImage(named: "CalendarUnselected"),
            selectedImage: UIImage(named: "CalendarSelected")
        )
        eventsNavigationController.tabBarItem = eventsTabBarItem
        
        setViewControllers([charactersNavigationController, eventsNavigationController], animated: false)
        selectedIndex = TabIndex.characters.rawValue
    }
    
    private enum TabIndex: Int {
        case characters = 0
    }
}
