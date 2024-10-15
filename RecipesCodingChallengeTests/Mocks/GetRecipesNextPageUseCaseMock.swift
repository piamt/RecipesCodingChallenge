//
//  GetRecipesNextPageUseCaseMock.swift
//  RecipesCodingChallengeTests
//
//  Created by Pia on 15/10/24.
//

import SwiftUI

enum GetRecipesNextPageUseCaseResult {
    case success(Recipes)
    case throwError(GetRecipesUseCaseError)
}

class GetRecipesNextPageUseCaseMock: GetRecipesNextPageUseCase {
    
    var result: GetRecipesNextPageUseCaseResult
    var link: String = ""
    
    init(result: GetRecipesNextPageUseCaseResult) {
        self.result = result
    }
    
    func execute(_ link: String) async throws -> Recipes {
        self.link = link
        
        switch result {
        case .success(let recipes):
            return recipes
        case .throwError(let error):
            throw error
        }
    }
}

