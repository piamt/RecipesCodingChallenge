//
//  RecipeDataSourceMock.swift
//  RecipesCodingChallengeTests
//
//  Created by Pia on 3/10/24.
//

import Foundation

enum RecipeDataSourceResult {
    case success(GetRecipe)
    case throwError(APIError)
}

struct RecipeDataSourceMock: RecipeDataSource {
    
    var result: RecipeDataSourceResult
    
    init(result: RecipeDataSourceResult) {
        self.result = result
    }
    
    func getRecipes(search: String) async throws -> GetRecipe {
        switch result {
        case .success(let recipes):
            return recipes
        case .throwError(let error):
            throw error
        }
    }
    
    func getRecipesNextPage(_ link: String) async throws -> GetRecipe {
        switch result {
        case .success(let recipes):
            return recipes
        case .throwError(let error):
            throw error
        }
    }
    
}

