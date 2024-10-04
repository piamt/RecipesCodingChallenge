//
//  GetRecipesUseCase.swift
//  RecipesCodingChallengeTests
//
//  Created by Pia on 3/10/24.
//

import Foundation
import SwiftUI

enum GetRecipesUseCaseResult {
    case success
    case throwError(GetRecipesUseCaseError)
}

class GetRecipesUseCaseMock: GetRecipesUseCase {
    
    var result: GetRecipesUseCaseResult
    
    init(result: GetRecipesUseCaseResult) {
        self.result = result
    }
    
    func execute(_ search: String) async throws -> Recipes {
        switch result {
        case .success:
            return Recipe.examples
        case .throwError(let error):
            throw error
        }
    }
}
