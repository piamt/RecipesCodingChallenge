//
//  RecipeDetailView.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 1/10/24.
//

import SwiftUI

struct RecipeDetailView: View {
    
    var viewModel: RecipeDetailViewModel
    
    init(recipe: Recipe) {
        self.viewModel = RecipeDetailViewModel(recipe: recipe)
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: viewModel.image)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                VStack(alignment: .leading) {
                    Text(LocalizedStringKey("ingredients_title")).font(.title2).padding(.vertical)
                    ForEach(viewModel.ingredients, id: \.self) { ingredient in
                        HStack {
                            Image(systemName: "checkmark.rectangle")
                            Text(ingredient)
                        }
                        .padding(.bottom, Padding.space.small)
                    }
                }
                .padding(.leading, Padding.space.xlarge)
                .padding(.trailing, Padding.space.xlarge)
                
                Spacer()
            }
        }
        .navigationTitle(viewModel.label)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: Recipe.examples[1])
    }
}
