//
//  GetRecipe.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 1/10/24.
//

import Foundation

struct GetRecipe: Codable {
    let hits: [RecipeContainer]
    let _links: LinksList
}

struct RecipeContainer: Codable {
    let recipe: Recipe
}

struct LinksList: Codable {
    let next: Link
}

struct Link: Codable {
    let href: String
    let title: String
}
