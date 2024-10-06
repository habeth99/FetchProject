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
        VStack {
            Text("Recipe's")
                .font(.title)
                .fontWeight(.semibold)
            if let error = viewModel.error {
                //Spacer()
                List {
                    HStack {
                        Spacer()
                        Text("Error fetching recipe's")
                        Spacer()
                    }
                    .listRowBackground(Color.clear)
                }
                .refreshable {
                    viewModel.fetchRecipes()
                }
                //Text(error)
                    //.padding()
                //Text("Error fetching recipe's")
                //Spacer()
            } else if (viewModel.recipes.isEmpty) {
                Spacer()
                Text("No Recipe's available")
                    .font(.title)
                Spacer()
            }
            else {
                List(viewModel.recipes) { recipe in
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
                    }
                }
                .refreshable {
                    viewModel.fetchRecipes()
                }
                
            }
        }
    }
}
//struct ContentView: View {
//    @EnvironmentObject var viewModel: RecipeViewModel
//    
//    var body: some View {
//        NavigationView {
//            Group {
//                if let error = viewModel.error {
//                    ErrorView(error: error)
//                } else if viewModel.recipes.isEmpty {
//                    EmptyStateView()
//                } else {
//                    RecipeListView(recipes: viewModel.recipes)
//                }
//            }
//            .navigationTitle("Recipes")
//            .refreshable {
//                viewModel.fetchRecipes()
//            }
//        }
//    }
//}
//
//struct ErrorView: View {
//    let error: String
//    
//    var body: some View {
//        VStack {
//            Spacer()
//            Text("Error fetching recipes")
//                .font(.headline)
//            Text(error)
//                .font(.subheadline)
//                .foregroundColor(.secondary)
//                .multilineTextAlignment(.center)
//                .padding()
//            Spacer()
//        }
//    }
//}
//
//struct EmptyStateView: View {
//    var body: some View {
//        VStack {
//            Spacer()
//            Text("No Recipes available")
//                .font(.title)
//            Text("Pull to refresh")
//                .font(.subheadline)
//                .foregroundColor(.secondary)
//            Spacer()
//        }
//    }
//}
//
//struct RecipeListView: View {
//    let recipes: [Recipe]
//    
//    var body: some View {
//        List(recipes) { recipe in
//            HStack {
//                KFImage.url(recipe.photoUrlSmall)
//                    .cancelOnDisappear(true)
//                    .fade(duration: 0.25)
//                    .placeholder { _ in
//                        Image(systemName: "photo")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 50, height: 50)
//                            .foregroundColor(.gray)
//                    }
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 50, height: 50)
//                    .cornerRadius(8)
//                
//                VStack(alignment: .leading) {
//                    Text(recipe.name)
//                        .font(.headline)
//                    Text(recipe.cuisine)
//                        .font(.subheadline)
//                }
//            }
//        }
//    }
//}

