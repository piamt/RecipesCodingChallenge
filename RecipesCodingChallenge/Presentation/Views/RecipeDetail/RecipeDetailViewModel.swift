//
//  RecipeDetailViewModel.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 3/10/24.
//

import Foundation

class RecipeDetailViewModel {
    
    let recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    var image: String {
        return recipe.image
    }
    
    var label: String {
        return recipe.label.capitalizingFirstLetter()
    }
    
    var ingredients: [String] {
        recipe.ingredients?.compactMap({ ingredient in
            guard let food = ingredient.food,
                let quantity = ingredient.quantity,
                let measure = ingredient.measure else {
                    return nil
            }
            return "\(food.capitalizingFirstLetter()): \(Double(round(quantity*100)/100)) \(measure)"
        }).uniqued() ?? []
    }
}
