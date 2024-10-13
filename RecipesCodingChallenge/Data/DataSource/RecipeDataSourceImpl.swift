//
//  RecipeDataSourceImpl.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 1/10/24.
//

import Foundation

struct RecipeDataSourceImpl: RecipeDataSource {
    func getRecipes(search: String) async throws -> GetRecipe {
        do {
            let recipe = try await APICaller.shared.fetch(
                endpoint: Endpoint.getRecipes(search: search),
                GetRecipe.self)
            return recipe
        } catch {
            throw error
        }
    }
    
    func getRecipesNextPage(_ link: String) async throws -> GetRecipe {
        do {
            let recipe = try await APICaller.shared.fetch(
                endpoint: Endpoint.getRecipesNextPage(link: link),
                GetRecipe.self)
            return recipe
        } catch {
            throw error
        }
    }
}
