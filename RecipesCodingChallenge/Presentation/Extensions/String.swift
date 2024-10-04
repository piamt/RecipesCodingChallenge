//
//  String.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 3/10/24.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
