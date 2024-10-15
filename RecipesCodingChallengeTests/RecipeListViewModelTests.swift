//
//  RecipeListViewModelTests.swift
//  RecipesCodingChallengeTests
//
//  Created by Pia on 1/10/24.
//

import XCTest
@testable import RecipesCodingChallenge

final class RecipeListViewModelTests: XCTestCase {
    
    var getRecipesUseCaseError: GetRecipesUseCaseMock!
    var getRecipesUseCaseSuccess: GetRecipesUseCaseMock!
    var getRecipesNextPageUseCase: GetRecipesNextPageUseCaseMock!
    var searchText: String = ""
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        ViewDispatcher.shared.dispatcher = DispatcherMock()
        
        getRecipesUseCaseError = GetRecipesUseCaseMock(result: .throwError(.decodingError))
        getRecipesUseCaseSuccess = GetRecipesUseCaseMock(result: .success(Recipes(recipes: Recipe.examples, nextLink: "next link")))
        getRecipesNextPageUseCase = GetRecipesNextPageUseCaseMock(result: .success(Recipes(recipes: Recipe.examples, nextLink: "next link")))
        searchText = "Chicken soup"
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
        
        ViewDispatcher.shared.dispatcher = DispatcherDefault()
        
        getRecipesUseCaseError = .none
        getRecipesUseCaseSuccess = .none
        searchText = ""
    }
    
    func testViewModelSuccess_when_GetRecipes_then_recipesFull() {
        // Given
        let viewModel = RecipeListViewModel(getRecipesUseCase: getRecipesUseCaseSuccess, getRecipesNextPageUseCase: getRecipesNextPageUseCase)
        let exp = expectation(description: "test")
        
        // When
        Task {
            do {
                viewModel.getRecipes(search: searchText)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 5.0)
    
        // Then
        XCTAssertEqual(Recipe.examples, viewModel.getRecipesArray)
    }
    
    func testViewModelSuccess_when_GetRecipes_then_lastSearchFull() {
        // Given
        let viewModel = RecipeListViewModel(getRecipesUseCase: getRecipesUseCaseSuccess, getRecipesNextPageUseCase: getRecipesNextPageUseCase)
        let exp = expectation(description: "test")
        
        // When
        Task {
            do {
                viewModel.getRecipes(search: searchText)
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 5.0)
    
        // Then
        XCTAssertEqual(searchText, viewModel.getLastSearch)
    }
    
    func testViewModelSuccess_when_GetRecipes_then_showAlertFalse() {
        // Given
        let viewModel = RecipeListViewModel(getRecipesUseCase: getRecipesUseCaseSuccess, getRecipesNextPageUseCase: getRecipesNextPageUseCase)
        let exp = expectation(description: "test")
        
        // When
        Task {
            do {
                viewModel.getRecipes(search: searchText)
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 5.0)
    
        // Then
        XCTAssertEqual(false, viewModel.showAlertUnknownError)
    }
    
    func testViewModelError_when_GetRecipes_then_recipesEmpty() {
        // Given
        let viewModel = RecipeListViewModel(getRecipesUseCase: getRecipesUseCaseError, getRecipesNextPageUseCase: getRecipesNextPageUseCase)
        let exp = expectation(description: "test")
        
        // When
        Task {
            do {
                viewModel.getRecipes(search: searchText)
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 5.0)
    
        // Then
        XCTAssertEqual([], viewModel.getRecipesArray)
    }
    
    func testViewModelError_when_GetRecipes_then_lastSearchFull() {
        // Given
        let viewModel = RecipeListViewModel(getRecipesUseCase: getRecipesUseCaseError, getRecipesNextPageUseCase: getRecipesNextPageUseCase)
        let exp = expectation(description: "test")
        
        // When
        Task {
            do {
                viewModel.getRecipes(search: searchText)
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 5.0)
    
        // Then
        XCTAssertEqual(searchText, viewModel.getLastSearch)
    }
    
    func testViewModelError_when_GetRecipes_then_showAlertTrue() {
        // Given
        let viewModel = RecipeListViewModel(getRecipesUseCase: getRecipesUseCaseError, getRecipesNextPageUseCase: getRecipesNextPageUseCase)
        let exp = expectation(description: "test")
        
        // When
        Task {
            do {
                viewModel.getRecipes(search: searchText)
            }
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 5.0)
    
        // Then
        XCTAssertEqual(true, viewModel.showAlertUnknownError)
    }
}

extension RecipeListViewModel {
    public var getRecipesArray: [Recipe] {
        self.recipes
    }
    
    public var getLastSearch: String {
        self.lastSearch
    }
}
