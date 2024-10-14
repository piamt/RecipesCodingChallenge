//
//  CoordinatorView.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 13/10/24.
//

import SwiftUI

struct CoordinatorView: View {
    
   @StateObject private var coordinator = Coordinator()
    private var uiTests: Bool = false
    
    init(uiTests: Bool = false) {
        self.uiTests = uiTests
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            let repository: RecipeRepository = uiTests ? RecipeRepositoryLocal() : RecipeRepositoryImp(dataSource: RecipeDataSourceImpl())
            coordinator.build(screen: .recipesList(repository: repository))
                .navigationDestination(for: Screen.self) { screen in
                    coordinator.build(screen: screen)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.buildSheet(sheet: sheet)
                }
                .fullScreenCover(item: $coordinator.fullScreenCover) { item in
                    coordinator.buildFullScreenCover(cover: item)
                }
        }
        .environmentObject(coordinator)
    }
}

struct CoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        CoordinatorView(uiTests: false)
    }
}
