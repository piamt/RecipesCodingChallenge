//
//  RecipeDataSourceImpl.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 1/10/24.
//

import Foundation

struct RecipeDataSourceImpl: RecipeDataSource {
    func getRecipes(search: String) async throws -> Recipes {
        do {
            let rec = try await APICaller.shared.fetch(
                endpoint: Endpoint.getRecipes(search: search),
                GetRecipe.self)
            return rec.hits.compactMap { return $0.recipe }
        } catch {
            throw error
        }
    }
}
