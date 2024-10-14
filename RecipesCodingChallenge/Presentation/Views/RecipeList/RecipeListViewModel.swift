//
//  RecipeListViewModel.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 1/10/24.
//

import Foundation

protocol RecipeListViewModelProtocol: ObservableObject {
    var getRecipeUseCase: GetRecipesUseCase { get set }
    var recipes: [Recipe] { get set }
    var nextLink: String? { get set }
    var searchButtonAvailable: Bool { get set }
    var showAlertInternetConnectivity: Bool { get set }
    var showAlertUnknownError: Bool { get set }
    var lastSearch: String { get set }
    
    func getRecipes(search: String)
    func getRecipesNextPage()
    func searchTextChanged()
}

class RecipeListViewModel: RecipeListViewModelProtocol {
    
    var getRecipeUseCase: GetRecipesUseCase
    
    @Published var recipes: [Recipe] = []
    var nextLink: String?
    @Published var searchButtonAvailable: Bool = true
    @Published var showAlertInternetConnectivity: Bool = false
    @Published var showAlertUnknownError: Bool = false
    var lastSearch = ""
    
    init(useCase: GetRecipesUseCase) {
        self.getRecipeUseCase = useCase
    }
    
    public func getRecipes(search: String) {
        guard lastSearch != search else { return }
        lastSearch = search
        Task {
            do {
                ViewDispatcher.shared.execute {
                    self.searchButtonAvailable = false
                    self.recipes = []
                }
                let rec = try await getRecipeUseCase.execute(search)
                ViewDispatcher.shared.execute {
                    self.recipes = rec.recipes
                    self.nextLink = rec.nextLink
                }
            } catch {
                errorManagement(error)
            }
        }
    }
    
    public func getRecipesNextPage() {
        Task {
            do {
                ViewDispatcher.shared.execute {
                    self.searchButtonAvailable = false
                }
                let rec = try await getRecipeUseCase.execute(lastSearch)
                ViewDispatcher.shared.execute {
                    self.recipes += rec.recipes
                }
            } catch {
                errorManagement(error)
            }
        }
    }
    
    private func errorManagement(_ error: Error) {
        ViewDispatcher.shared.execute {
            self.searchButtonAvailable = true
        }
        guard let useCaseError = error as? GetRecipesUseCaseError else {
            ViewDispatcher.shared.execute {
                self.showAlertUnknownError = true
            }
            return
        }
        switch useCaseError {
        case .networkError:
            ViewDispatcher.shared.execute {
                self.showAlertInternetConnectivity = true
            }
        case .decodingError, . undefinedError:
            ViewDispatcher.shared.execute {
                self.showAlertUnknownError = true
            }
        }
    }
    
    func searchTextChanged() {
        ViewDispatcher.shared.execute {
            self.searchButtonAvailable = true
        }
    }
}
