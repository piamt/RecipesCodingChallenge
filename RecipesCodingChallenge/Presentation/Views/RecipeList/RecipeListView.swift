//
//  RecipeListView.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 1/10/24.
//

import SwiftUI

struct RecipeListView: View {
    
    @ObservedObject var viewModel: RecipeListViewModel
    @State private var searchText = ""
    @State private var fetchingRecipes = false
    
    init(useCase: GetRecipesUseCase) {
        self.viewModel = RecipeListViewModel(useCase: useCase)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(viewModel.recipes, id: \.uri) { recipe in
                        NavigationLink(value: recipe) {
                            RecipeCell(recipe: recipe)
                        }
                    }
                }
                .accessibilityIdentifier("list_recipes")
                .searchable(text: $searchText, prompt: LocalizedStringKey("search_recipes_placeholder"))
                .onChange(of: searchText) { value in
                    viewModel.searchTextChanged()
                    /*Task {
                        if !value.isEmpty && value.count > 3 {
                            viewModel.getRecipes(search: value)
                        } else {
                            viewModel.recipes.removeAll()
                        }
                    }*/
                }
                .navigationTitle(LocalizedStringKey("recipes_title"))
                .navigationDestination(for: Recipe.self) { recipe in
                    RecipeDetailView(recipe: recipe)
                }
                
                VStack {
                    Spacer()
                    Button(LocalizedStringKey("search_button")) {
                        if !searchText.isEmpty {
                            viewModel.getRecipes(search: searchText)
                        }
                    }
                    .buttonStyle(SearchButtonStyle())
                    .disabled(!viewModel.searchButtonAvailable)
                }
                
            }
        }
        .alert(LocalizedStringKey("network_error"), isPresented: $viewModel.showAlertInternetConnectivity) {
            Button(LocalizedStringKey("ok_button"), role: .cancel) { }
        }
        .alert(LocalizedStringKey("unknown_error"), isPresented: $viewModel.showAlertUnknownError) {
            Button(LocalizedStringKey("ok_button"), role: .cancel) { }
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView(useCase: GetRecipesUseCaseImpl(repository: RecipeRepositoryLocal()))
    }
}
