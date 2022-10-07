//
//  UIViewController+Extensions.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 07/10/2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showError(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        DispatchQueue.main.async { [weak self] in
            self?.present(alertController, animated: true)
        }
    }
}
