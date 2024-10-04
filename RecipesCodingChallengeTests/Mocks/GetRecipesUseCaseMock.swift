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
    var completion: (() -> Void)?
    
    init(result: GetRecipesUseCaseResult) {
        self.result = result
    }
    
    func execute(_ search: String) async throws -> Recipes {
        completion?()
        switch result {
        case .success:
            return Recipe.examples
        case .throwError(let error):
            throw error
        }
    }
}
