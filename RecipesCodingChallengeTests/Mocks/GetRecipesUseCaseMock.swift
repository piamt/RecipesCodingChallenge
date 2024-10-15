//
//  GetRecipesUseCase.swift
//  RecipesCodingChallengeTests
//
//  Created by Pia on 3/10/24.
//

import SwiftUI

enum GetRecipesUseCaseResult {
    case success(Recipes)
    case throwError(GetRecipesUseCaseError)
}

class GetRecipesUseCaseMock: GetRecipesUseCase {
    
    var result: GetRecipesUseCaseResult
    
    init(result: GetRecipesUseCaseResult) {
        self.result = result
    }
    
    func execute(_ search: String) async throws -> Recipes {
        switch result {
        case .success(let recipes):
            return recipes
        case .throwError(let error):
            throw error
        }
    }
}
