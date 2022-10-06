//
//  ImageProvider.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 06/10/2022.
//

import Foundation
import UIKit

class ImageProvider {
    
    static let shared = ImageProvider()
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    private init() {
        imageCache.totalCostLimit = 200 * 1024 * 1024 // 200MB
    }
    
    private func imageKey(from path: String, fileExtension: String) -> NSString {
        return NSString(string: "\(path).\(fileExtension)")
    }
    
    func getImage(path: String, fileExtension: String, callback: @escaping (UIImage?) -> Void) {
        let key = imageKey(from: path, fileExtension: fileExtension)
        guard let image = imageCache.object(forKey: key) else {
            fetchImage(path: path, fileExtension: fileExtension, callback: callback)
            return
        }
        callback(image)
    }
    
    private func fetchImage(path: String, fileExtension: String, callback: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: "\(path).\(fileExtension)") else {
            callback(nil)
            return
        }
        DispatchQueue.global().async {
            guard let image = UIImage(from: url) else {
                callback(nil)
                return
            }
            let key = self.imageKey(from: path, fileExtension: fileExtension)
            self.imageCache.setObject(image, forKey: key)
            DispatchQueue.main.async {
                callback(image)
            }
        }
    }
}
