//
//  RecipeListViewModel.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 1/10/24.
//

import Foundation

protocol RecipeListViewModelProtocol: ObservableObject {
    var recipes: [Recipe] { get }
    var searchButtonAvailable: Bool { get }
    var showAlertInternetConnectivity: Bool { get set }
    var showAlertUnknownError: Bool { get set }
    
    func getRecipes(search: String)
    func getRecipesNextPage()
    func searchTextChanged()
}

class RecipeListViewModel: RecipeListViewModelProtocol {
    
    private var getRecipesUseCase: GetRecipesUseCase
    private var getRecipesNextPageUseCase: GetRecipesNextPageUseCase
    var lastSearch = ""
    private var nextLink: String?
    
    @Published private(set) var recipes: [Recipe] = []
    @Published private(set) var searchButtonAvailable: Bool = true
    @Published var showAlertInternetConnectivity: Bool = false
    @Published var showAlertUnknownError: Bool = false
    
    init(getRecipesUseCase: GetRecipesUseCase, getRecipesNextPageUseCase: GetRecipesNextPageUseCase) {
        self.getRecipesUseCase = getRecipesUseCase
        self.getRecipesNextPageUseCase = getRecipesNextPageUseCase
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
                let rec = try await getRecipesUseCase.execute(lastSearch)
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
        guard let link = nextLink else { return }
        Task {
            do {
                ViewDispatcher.shared.execute {
                    self.searchButtonAvailable = false
                }
                let rec = try await getRecipesNextPageUseCase.execute(link)
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
