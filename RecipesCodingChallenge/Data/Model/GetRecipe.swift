//
//  GetRecipe.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 1/10/24.
//

import Foundation

struct GetRecipe: Codable {
    let hits: [RecipeContainer]
}

struct RecipeContainer: Codable {
    let recipe: Recipe
}
