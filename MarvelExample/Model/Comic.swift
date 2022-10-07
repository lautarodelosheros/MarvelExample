//
//  Comic.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 07/10/2022.
//

import Foundation

struct Comic: Codable {
    
    let id: Int
    let title: String
    let dates: [ComicDate]?
}

struct ComicDate: Codable {
    
    let type: String
    let date: Date?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(String.self, forKey: .type)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let dateString = try container.decodeIfPresent(String.self, forKey: .date),
           let date = dateFormatter.date(from: dateString) {
            self.date = date
        } else {
            date = nil
        }
    }
}
