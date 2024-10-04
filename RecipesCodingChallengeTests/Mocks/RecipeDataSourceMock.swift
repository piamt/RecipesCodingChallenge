//
//  RecipeDataSourceMock.swift
//  RecipesCodingChallengeTests
//
//  Created by Pia on 3/10/24.
//

import Foundation

enum RecipeDataSourceResult {
    case success
    case throwError(APIError)
}

struct RecipeDataSourceMock: RecipeDataSource {
    
    var result: RecipeDataSourceResult
    
    init(result: RecipeDataSourceResult) {
        self.result = result
    }
    
    func getRecipes(search: String) async throws -> Recipes {
        switch result {
        case .success:
            return Recipe.examples
        case .throwError(let error):
            throw error
        }
    }
}

