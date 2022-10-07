//
//  URL+Extensions.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 05/10/2022.
//

import Foundation

extension URL {
    
    func paginatedBy(pageNumber: Int, pageSize: Int) -> URL {
        let limitQueryItem = URLQueryItem(name: "limit", value: String(pageSize))
        let offset = pageNumber * pageSize
        let offsetQueryItem = URLQueryItem(name: "offset", value: String(offset))
        return self.appending(queryItems: [limitQueryItem, offsetQueryItem])
    }
}
