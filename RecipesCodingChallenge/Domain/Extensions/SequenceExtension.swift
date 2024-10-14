//
//  SequenceExtension.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 13/10/24.
//

import Foundation

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
