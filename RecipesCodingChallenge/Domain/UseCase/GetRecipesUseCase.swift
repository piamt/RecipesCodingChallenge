//
//  GetRecipesUseCase.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 1/10/24.
//

import Foundation

enum GetRecipesUseCaseError: Error {
    case networkError
    case decodingError
    case undefinedError
    
    static func mapStatus(_ error: APIError) -> GetRecipesUseCaseError {
        switch error {
        case .badRequest:
            return GetRecipesUseCaseError.networkError
        case .unauthorized:
            return GetRecipesUseCaseError.undefinedError
        case .forbidden:
            return GetRecipesUseCaseError.undefinedError
        case .notFound:
            return GetRecipesUseCaseError.undefinedError
        case .decodingError:
            return GetRecipesUseCaseError.decodingError
        case .unknown:
            return GetRecipesUseCaseError.undefinedError
        }
    }
}

protocol GetRecipesUseCase {
    func execute(_ search: String) async throws -> Recipes
}

struct GetRecipesUseCaseImpl: GetRecipesUseCase {
    var repository: RecipeRepository
    
    func execute(_ search: String) async throws -> Recipes {
        do {
            return try await repository.getRecipes(search: search)
        } catch {
            guard let apiError = error as? APIError else {
                throw GetRecipesUseCaseError.undefinedError
            }
            throw GetRecipesUseCaseError.mapStatus(apiError)
        }
    }
}
