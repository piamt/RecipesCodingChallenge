//
//  Screen.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 13/10/24.
//

import Foundation

enum Screen: Identifiable, Hashable {
    case recipesList(repository: RecipeRepository)
    case recipeDetail(recipe: Recipe)
    
    var id: String {
        switch self {
        case .recipesList: return "recipeList"
        case .recipeDetail: return "recipeDetail"
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        switch (lhs, rhs) {
        case (.recipesList, .recipesList), (.recipeDetail, .recipeDetail):
            return true
        default:
            return false
        }
    }
}

enum Sheet: Identifiable, Hashable {
    case recipeDetail(recipe: Recipe)
    // TODO: Add alert
    
    var id: String {
        switch self {
        case .recipeDetail: return "recipeDetail"
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
   
}

enum FullScreenCover: Identifiable, Hashable {
    case recipeDetail(recipe: Recipe)
    
    var id: String {
        switch self {
        case .recipeDetail: return "recipeDetail"
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
