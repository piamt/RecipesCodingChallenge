//
//  RecipeRepositoryTests.swift
//  RecipesCodingChallengeTests
//
//  Created by Pia on 3/10/24.
//

import XCTest
@testable import RecipesCodingChallenge

final class RecipeRepositoryTests: XCTestCase {
    
    var getRecipeDataSourceError: RecipeDataSourceMock!
    var getRecipeDataSourceSuccess: RecipeDataSourceMock!
    var searchText: String = ""
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        ViewDispatcher.shared.dispatcher = DispatcherMock()
        
        let recipes = GetRecipe(
            hits: Recipe.examples.map{ RecipeContainer(recipe: $0) },
            _links: LinksList(next: Link(href: "next page link", title: "title")))
        
        getRecipeDataSourceError = RecipeDataSourceMock(result: .throwError(APIError.badRequest))
        getRecipeDataSourceSuccess = RecipeDataSourceMock(result: .success(recipes))
        searchText = "Chicken soup"
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
        
        ViewDispatcher.shared.dispatcher = DispatcherDefault()
        
        getRecipeDataSourceError = .none
        getRecipeDataSourceSuccess = .none
        searchText = ""
    }
    
    func testRepositorySuccess_when_GetRecipes_then_recipesFull() async {
        // Given
        let repository = RecipeRepositoryImp(dataSource: getRecipeDataSourceSuccess)
        
        // When
        do {
            let recipes = try await repository.getRecipes(search: "")
            // Then
            XCTAssertEqual(Recipe.examples, recipes.recipes)
        } catch {
            XCTFail()
        }
    }
    
    func testRepositoryError_when_GetRecipes_then_throwsAPIError() async {
        // Given
        let repository = RecipeRepositoryImp(dataSource: getRecipeDataSourceError)
    
        // When
        do {
            _ = try await repository.getRecipes(search: "")
            XCTFail()
        } catch {
            // Then
            XCTAssertEqual((error as? APIError), APIError.badRequest)
        }
    }
}
