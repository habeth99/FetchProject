//
//  FetchProjectApp.swift
//  FetchProject
//
//  Created by Nick Habeth on 10/5/24.
//

import SwiftUI

@main
struct FetchProjectApp: App {
    @StateObject private var recipeViewModel = RecipeViewModel()
    
    init() {
        print("FetchProjectApp initialized")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(recipeViewModel)
                .task {
                    recipeViewModel.fetchRecipes()
                }
        }
    }
}
