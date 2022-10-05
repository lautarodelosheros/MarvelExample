//
//  MarvelAPIClient.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 05/10/2022.
//

import Foundation
import Alamofire

class MarvelAPIClient {
    
    private var baseUrl = URL(string: "https://gateway.marvel.com/v1/")!
    private let publicApiKey = "3a783b25c80e1c44875356dd363f272d"
    private let hash = "51a3ecf2f92a23817992a2663183325e"
    private let timestamp = "1"
    
    init() {
        let apiKeyQueryItem = URLQueryItem(name: "apikey", value: publicApiKey)
        let hashQueryItem = URLQueryItem(name: "hash", value: hash)
        let timestampQueryItem = URLQueryItem(name: "ts", value: timestamp)
        baseUrl.append(queryItems: [apiKeyQueryItem, hashQueryItem, timestampQueryItem])
    }
    
    func getCharacters() {
        let url = baseUrl.appendingPathComponent(MarvelEndpoints.public)
            .appendingPathComponent(MarvelEndpoints.characters)
        Session.default.request(url).responseDecodable(of: MarvelResponse<Character>.self) { responseData in
            switch responseData.result {
            case .success(let response):
                debugPrint(response)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
