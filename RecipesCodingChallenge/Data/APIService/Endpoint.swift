//
//  Endpoint.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 1/10/24.
//

import Foundation

enum HTTPMethod: String {
    case `GET`
    case POST
}

enum Endpoint {
    case getRecipes(search: String)
    case getRecipesNextPage(link: String)
    
    private var baseURL: URL? {
        URL(string: "https://api.edamam.com/".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
    
    private var path: String {
        switch self {
        case .getRecipes:
            return "api/recipes/v2"
        case .getRecipesNextPage:
            return ""
        }
    }
    
    var url: URL? {
        switch self {
        case .getRecipesNextPage(let link):
            return URL(string: link)
        default:
            return baseURL?.appending(path: path)
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getRecipes, .getRecipesNextPage:
            return .GET
        }
    }
    
    var customParams: [String: Any]? {
        switch self {
        case .getRecipes(let search):
            return [
                "q": search,
                "field": ["uri", "label", "image", "ingredients"]
            ]
        case .getRecipesNextPage: return nil
        }
    }
    
    var sharedParams: [String: Any] { // TODO: Define an alternative way to save sensitive data (example: CloudKit)
        if case .getRecipesNextPage = self {
            return [:]
        }
        
        return [
            "type": "public",
            "app_id": Obfuscator().reveal(key: Constants.app_id), //"a6be5d17"
            "app_key": Obfuscator().reveal(key: Constants.app_key) //"08a8b200954717c900b1a77c47a9d78c"
        ]
    }
    
    var body: Any { // TODO: Update when POST method added to the project
        return ""
    }
}
