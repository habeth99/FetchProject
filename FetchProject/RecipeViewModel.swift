//
//  RecipeViewModel.swift
//  FetchProject
//
//  Created by Nick Habeth on 10/6/24.
//

import Foundation
import SwiftUI
import Combine

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var error: String?
    private var cancellables = Set<AnyCancellable>()
    
    func fetchRecipes() {
        guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") else {
            self.error = "Invalid URL"
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: RecipeResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = "Error fetching recipes: \(error.localizedDescription)"
                    print("Detailed error: \(error)")
                }
            } receiveValue: { [weak self] response in
                self?.recipes = response.recipes
                self?.error = nil
            }
            .store(in: &cancellables)
    }
}

struct RecipeResponse: Codable {
    let recipes: [Recipe]
}
