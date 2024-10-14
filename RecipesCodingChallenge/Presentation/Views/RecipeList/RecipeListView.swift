//
//  RecipeListView.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 1/10/24.
//

import SwiftUI

struct RecipeListView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject private var viewModel: RecipeListViewModel
    @State private var searchText = ""
    @State private var fetchingRecipes = false
    private static let paginationLimitScroll = 5
    
    init(repository: RecipeRepository) {
        _viewModel = StateObject(wrappedValue: RecipeListViewModel(useCase: GetRecipesUseCaseImpl(repository: repository)))
    }
    
    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.recipes.indices, id: \.self) { index in
                    let recipe = viewModel.recipes[index]
                    RecipeCell(recipe: recipe)
                        .onAppear() {
                            if index+RecipeListView.paginationLimitScroll == viewModel.recipes.count {
                                viewModel.getRecipesNextPage()
                            }
                        }
                        .onTapGesture {
                            coordinator.push(.recipeDetail(recipe: recipe))
                        }
                }
            }
            .accessibilityIdentifier("list_recipes")
            .searchable(text: $searchText, prompt: LocalizedStringKey("search_recipes_placeholder"))
            .onChange(of: searchText) { value in
                viewModel.searchTextChanged()
                // In case you want to search while texting
                /*Task {
                    if !value.isEmpty && value.count > 3 {
                        viewModel.getRecipes(search: value)
                    } else {
                        viewModel.recipes.removeAll()
                    }
                }*/
            }
            .navigationTitle(LocalizedStringKey("recipes_title"))
            
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
        RecipeListView(repository: RecipeRepositoryLocal())
    }
}
