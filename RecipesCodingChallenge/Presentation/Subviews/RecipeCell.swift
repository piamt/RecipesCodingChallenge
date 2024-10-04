//
//  RecipeCell.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 1/10/24.
//

import SwiftUI

struct RecipeCell: View {
    
    var recipe: Recipe
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: recipe.image)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 100)
            } placeholder: {
                ProgressView()
            }
            Text(recipe.label)
        }
    }
}

struct RecipeCell_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCell(recipe: Recipe.examples.first!)
    }
}
