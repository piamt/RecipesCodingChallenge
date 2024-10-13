//
//  RecipeDataSourceMock.swift
//  RecipesCodingChallengeTests
//
//  Created by Pia on 3/10/24.
//

import Foundation

enum RecipeDataSourceResult {
    case success
    case throwError(APIError)
}

struct RecipeDataSourceMock: RecipeDataSource {
    
    var result: RecipeDataSourceResult
    
    init(result: RecipeDataSourceResult) {
        self.result = result
    }
    
    private var recipes: GetRecipe {
        GetRecipe(
            hits: Recipe.examples.map{ RecipeContainer(recipe: $0) },
            _links: LinksList(next: Link(href: "next page link", title: "title")))
    }
    
    func getRecipes(search: String) async throws -> GetRecipe {
        switch result {
        case .success:
            return recipes
        case .throwError(let error):
            throw error
        }
    }
    
    func getRecipesNextPage(_ link: String) async throws -> GetRecipe {
        switch result {
        case .success:
            return recipes
        case .throwError(let error):
            throw error
        }
    }
    
}

