//
//  UIImage+Extensions.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 06/10/2022.
//

import Foundation
import UIKit

extension UIImage {
    
    convenience init?(from url: URL) {
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        self.init(data: data)
    }
}
