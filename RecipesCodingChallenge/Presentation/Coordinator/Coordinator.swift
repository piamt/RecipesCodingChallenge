//
//  Coordinator.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 13/10/24.
//

import Foundation
import SwiftUI

protocol CoordinatorProtocol: ObservableObject {
    var path: NavigationPath { get set }
    var sheet: Sheet? { get set }
    var fullScreenCover: FullScreenCover? { get set }
    
    func push(_ screen: Screen)
    func presentSheet(_ sheet: Sheet)
    func presentFullScreenCover(_ cover: FullScreenCover)
    func pop()
    func popToRoot()
    func dismissSheet()
    func dismissFullScreenCover()
}

class Coordinator: CoordinatorProtocol {
    @Published var path: NavigationPath = NavigationPath()
    @Published var sheet: Sheet?
    @Published var fullScreenCover: FullScreenCover?
    
    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    func presentSheet(_ sheet: Sheet) {
        self.sheet = sheet
    }
    
    func presentFullScreenCover(_ cover: FullScreenCover) {
        self.fullScreenCover = cover
    }
        
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }
    
    @ViewBuilder
    func build(screen: Screen) -> some View {
        switch screen {
        case .recipesList(let repository): RecipeListView(repository: repository)
        case .recipeDetail(let recipe): RecipeDetailView(recipe: recipe)
        }
    }
    
    @ViewBuilder
    func buildSheet(sheet: Sheet) -> some View {
        switch sheet {
        case .recipeDetail(let recipe):
            NavigationStack {
                RecipeDetailView(recipe: recipe)
            }
        }
    }
    
    @ViewBuilder
    func buildFullScreenCover(cover: FullScreenCover) -> some View {
        switch cover {
        case .recipeDetail(let recipe):
            NavigationStack {
                RecipeDetailView(recipe: recipe)
            }
        }
    }
}
