//
//  Recipe.swift
//  FetchProject
//
//  Created by Nick Habeth on 10/5/24.
//

import Foundation
import SwiftUI

class Recipe: ObservableObject {
    @Published var cuisine: String
    @Published var name: String
    @Published var photoUrlLarge: URL
    @Published var photoUrlSmall: URL
    @Published var uuid: UUID
    @Published var youtube_Url: URL
    
    init(cuisine: String, name: String, photoUrlLarge: URL, photoUrlSmall: URL, uuid: UUID, youtube_Url: URL) {
        self.cuisine = cuisine
        self.name = name
        self.photoUrlLarge = photoUrlLarge
        self.photoUrlSmall = photoUrlSmall
        self.uuid = uuid
        self.youtube_Url = youtube_Url
    }
}
