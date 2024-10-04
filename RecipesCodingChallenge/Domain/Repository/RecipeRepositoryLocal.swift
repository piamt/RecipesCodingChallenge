//
//  RecipeRepositoryLocal.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 3/10/24.
//

import Foundation

struct RecipeRepositoryLocal: RecipeRepository {
    
    func getRecipes(search: String) async throws -> Recipes {
        return Recipe.examples
    }
}
