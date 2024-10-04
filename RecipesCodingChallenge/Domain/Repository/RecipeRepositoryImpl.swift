//
//  RecipeRepositoryImpl.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 1/10/24.
//

import Foundation

struct RecipeRepositoryImp: RecipeRepository {
    
    var dataSource: RecipeDataSource
    
    func getRecipes(search: String) async throws -> Recipes {
        do {
            return try await dataSource.getRecipes(search: search)
        } catch {
            throw error
        }
    }
}
