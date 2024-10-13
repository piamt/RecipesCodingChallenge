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
            let getRecipes = try await dataSource.getRecipes(search: search)
            let recipes = getRecipes.hits.compactMap { $0.recipe }
            let nextLink = getRecipes._links.next.href
            return Recipes(recipes: recipes, nextLink: nextLink)
        } catch {
            throw error
        }
    }
    
    
    func getRecipesNextPage(link: String) async throws -> Recipes {
        do {
            let getRecipes = try await dataSource.getRecipesNextPage(link)
            let recipes = getRecipes.hits.compactMap { $0.recipe }
            let nextLink = getRecipes._links.next.href
            return Recipes(recipes: recipes, nextLink: nextLink)
        } catch {
            throw error
        }
    }
}
