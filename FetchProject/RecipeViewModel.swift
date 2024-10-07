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
    @Published var favoriteRecipes: Set<UUID> = Set()
    private var cancellables = Set<AnyCancellable>()
    
    
    private let networkService: NetworkService
    private let baseURL: URL
    
    init(networkService: NetworkService = URLSessionNetworkService(),
         baseURL: URL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net")!) {
        self.networkService = networkService
        self.baseURL = baseURL
    }
    
    func fetchRecipes(from url: URL? = nil) {
        // this appends the proper url base the first one is the endpoint for the normal data
        // the second one has the malformed data and the third has the empty data
        // uncomment the other url to see the app in the other scenarios
        
        let recipesURL = url ?? baseURL.appendingPathComponent("recipes.json")
        //let recipesURL = url ?? baseURL.appendingPathComponent("recipes-malformed.json")
        //let recipesURL = url ?? baseURL.appendingPathComponent("recipes-empty.json")
        
        print("Fetching recipes from: \(recipesURL)")
        
        networkService.fetch(from: recipesURL)
            .map { data, response -> Data in
                print("Received data of size: \(data.count) bytes")
                return data
            }
            .decode(type: RecipeResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                print("Sink completion received: \(completion)")
                if case .failure(let error) = completion {
                    self?.error = "Error fetching recipes: \(error.localizedDescription)"
                    print("Detailed error: \(error)")
                }
            } receiveValue: { [weak self] response in
                print("Received response with \(response.recipes.count) recipes")
                self?.recipes = response.recipes
                self?.error = nil
            }
            .store(in: &cancellables)
    }
    
    func toggleFavorite(for recipe: Recipe) {
        if favoriteRecipes.contains(recipe.id) {
            favoriteRecipes.remove(recipe.id)
        } else {
            favoriteRecipes.insert(recipe.id)
        }
    }

    func isFavorite(_ recipe: Recipe) -> Bool {
        return favoriteRecipes.contains(recipe.id)
    }
}

struct RecipeResponse: Codable {
    let recipes: [Recipe]
}

