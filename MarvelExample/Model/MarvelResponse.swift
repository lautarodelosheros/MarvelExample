//
//  MarvelResponse.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 05/10/2022.
//

import Foundation

struct MarvelResponse<T: Codable>: Codable {
    
    let data: MarvelResponseData<T>
}

struct MarvelResponseData<T: Codable>: Codable {
    
    let results: [T]
}
