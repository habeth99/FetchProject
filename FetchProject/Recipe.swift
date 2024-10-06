//
//  Recipe.swift
//  FetchProject
//
//  Created by Nick Habeth on 10/5/24.
//

import Foundation
import SwiftUI

struct Recipe: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let cuisine: String
    let photoUrlLarge: URL
    let photoUrlSmall: URL
    let sourceUrl: URL?
    let youtubeUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name, cuisine
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        cuisine = try container.decode(String.self, forKey: .cuisine)
        photoUrlLarge = try container.decode(URL.self, forKey: .photoUrlLarge)
        photoUrlSmall = try container.decode(URL.self, forKey: .photoUrlSmall)
        sourceUrl = try container.decodeIfPresent(URL.self, forKey: .sourceUrl)
        youtubeUrl = try container.decodeIfPresent(URL.self, forKey: .youtubeUrl)
        //youtubeUrl = try container.decode(URL.self, forKey: .youtubeUrl)
    }
}
