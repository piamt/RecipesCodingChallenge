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
                CoordinatorView(uiTests: true)
            } else {
                CoordinatorView()
            }
        }
    }
}
