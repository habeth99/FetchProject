//
//  ContentView.swift
//  FetchProject
//
//  Created by Nick Habeth on 10/5/24.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @EnvironmentObject var viewModel: RecipeViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                if let error = viewModel.error {
                    VStack {
                        Text(error)
                            .font(.title3)
                            .padding()
                        Text("pull to refresh")
                            .padding()
                    }
                } else if (viewModel.recipes.isEmpty){
                    VStack {
                        Spacer()
                        Text("No recipe's available")
                            .font(.title3)
                            .padding()
                        Spacer()
                    }
                }
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.recipes) { recipe in
                        HStack {
                            KFImage(recipe.photoUrlSmall)
                                .resizable()
                                .placeholder {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                            
                            VStack(alignment: .leading) {
                                Text(recipe.name)
                                    .font(.headline)
                                Text(recipe.cuisine)
                                    .font(.subheadline)
                            }
                            Spacer()
                            
                            Button(action: {
                                viewModel.toggleFavorite(for: recipe)
                            }) {
                                Image(systemName: viewModel.isFavorite(recipe) ? "star.fill" : "star")
                                    .foregroundColor(viewModel.isFavorite(recipe) ? .yellow : .gray)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .refreshable {
                viewModel.fetchRecipes()
            }
            .navigationTitle("Recipe's")
        }
    }
}
