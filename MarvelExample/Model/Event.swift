//
//  Event.swift
//  MarvelExample
//
//  Created by Lautaro de los Heros on 07/10/2022.
//

import Foundation

struct Event: Codable {
    
    let id: Int
    let title: String
    let start: Date?
    let thumbnail: RemoteResourceFile?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        thumbnail = try container.decodeIfPresent(RemoteResourceFile.self, forKey: .thumbnail)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let dateString = try container.decodeIfPresent(String.self, forKey: .start),
           let date = dateFormatter.date(from: dateString) {
            start = date
        } else {
            start = nil
        }
    }
}
