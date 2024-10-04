//
//  RecipesCodingChallengeApp.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 1/10/24.
//

import SwiftUI

@main
struct RecipesCodingChallengeApp: App {
    
    var body: some Scene {
        WindowGroup {
            if CommandLine.arguments.contains("-UITests") {
                RecipeListView(useCase: GetRecipesUseCaseImpl(repository: RecipeRepositoryLocal()))
            } else {
                RecipeListView(useCase: GetRecipesUseCaseImpl(repository: RecipeRepositoryImp(dataSource: RecipeDataSourceImpl())))
            }
        }
    }
}
