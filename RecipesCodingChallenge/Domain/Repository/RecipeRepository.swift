//
//  RecipeRepository.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 1/10/24.
//

import Foundation

protocol RecipeRepository {
    func getRecipes(search: String) async throws -> Recipes
}
