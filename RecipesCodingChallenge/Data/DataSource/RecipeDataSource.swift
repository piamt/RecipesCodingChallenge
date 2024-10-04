//
//  RecipeDataSource.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 1/10/24.
//

import Foundation

protocol RecipeDataSource {
    func getRecipes(search: String) async throws -> Recipes
}
