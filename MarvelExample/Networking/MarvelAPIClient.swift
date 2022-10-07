//
//  MarvelAPIClient.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 05/10/2022.
//

import Foundation
import Alamofire

class MarvelAPIClient {
    
    static let `default` = MarvelAPIClient()
    
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
    
    func getCharacters(pageNumber: Int, pageSize: Int, onCompletion: @escaping () -> Void, onSuccess: @escaping ([Character]) -> Void, onFailure: @escaping (Error) -> Void) {
        let url = baseUrl.appendingPathComponent(MarvelEndpoints.public)
            .appendingPathComponent(MarvelEndpoints.characters)
            .paginatedBy(pageNumber: pageNumber, pageSize: pageSize)
        Session.default.request(url).responseDecodable(of: MarvelResponse<Character>.self) { responseData in
            onCompletion()
            switch responseData.result {
            case .success(let response):
                onSuccess(response.data.results)
            case .failure(let error):
                onFailure(error)
            }
        }
    }
    
    func getEvents(pageNumber: Int, pageSize: Int, onCompletion: @escaping () -> Void, onSuccess: @escaping ([Event]) -> Void, onFailure: @escaping (Error) -> Void) {
        var url = baseUrl.appendingPathComponent(MarvelEndpoints.public)
            .appendingPathComponent(MarvelEndpoints.events)
            .paginatedBy(pageNumber: pageNumber, pageSize: pageSize)
        let orderByQueryItem = URLQueryItem(name: "orderBy", value: "startDate")
        url.append(queryItems: [orderByQueryItem])
        Session.default.request(url).responseDecodable(of: MarvelResponse<Event>.self) { responseData in
            onCompletion()
            switch responseData.result {
            case .success(let response):
                onSuccess(response.data.results)
            case .failure(let error):
                onFailure(error)
            }
        }
    }
    
    func getCharacterComics(characterId: Int, pageNumber: Int, pageSize: Int, onCompletion: @escaping () -> Void, onSuccess: @escaping ([Comic]) -> Void, onFailure: @escaping (Error) -> Void) {
        let url = baseUrl.appendingPathComponent(MarvelEndpoints.public)
            .appendingPathComponent(MarvelEndpoints.characters)
            .appendingPathComponent(String(characterId))
            .appendingPathComponent(MarvelEndpoints.comics)
            .paginatedBy(pageNumber: pageNumber, pageSize: pageSize)
        Session.default.request(url).responseDecodable(of: MarvelResponse<Comic>.self) { responseData in
            onCompletion()
            switch responseData.result {
            case .success(let response):
                onSuccess(response.data.results)
            case .failure(let error):
                onFailure(error)
            }
        }
    }
    
    func getEventComics(eventId: Int, pageNumber: Int, pageSize: Int, onCompletion: @escaping () -> Void, onSuccess: @escaping ([Comic]) -> Void, onFailure: @escaping (Error) -> Void) {
        let url = baseUrl.appendingPathComponent(MarvelEndpoints.public)
            .appendingPathComponent(MarvelEndpoints.events)
            .appendingPathComponent(String(eventId))
            .appendingPathComponent(MarvelEndpoints.comics)
            .paginatedBy(pageNumber: pageNumber, pageSize: pageSize)
        Session.default.request(url).responseDecodable(of: MarvelResponse<Comic>.self) { responseData in
            onCompletion()
            switch responseData.result {
            case .success(let response):
                onSuccess(response.data.results)
            case .failure(let error):
                onFailure(error)
            }
        }
    }
}
