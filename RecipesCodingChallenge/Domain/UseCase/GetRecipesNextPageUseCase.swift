//
//  GetRecipesNextPageUseCase.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 13/10/24.
//

import Foundation

protocol GetRecipesNextPageUseCase {
    func execute(_ link: String) async throws -> Recipes
}

struct GetRecipesNextPageUseCaseImpl: GetRecipesNextPageUseCase {
    var repository: RecipeRepository
    
    func execute(_ link: String) async throws -> Recipes {
        do {
            return try await repository.getRecipesNextPage(link: link)
        } catch {
            guard let apiError = error as? APIError else {
                throw GetRecipesUseCaseError.undefinedError
            }
            throw GetRecipesUseCaseError.mapStatus(apiError)
        }
    }
}

