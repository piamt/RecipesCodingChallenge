//
//  DictionaryExtension.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 2/10/24.
//

import Foundation

extension Dictionary where Key == String {
    var queryItemArray: [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        self.forEach { (key: String, value: Value) in
            if let valueString = value as? String {
                queryItems.append(URLQueryItem(name: key, value: valueString))
            } else if let valueArray = value as? [String] {
                valueArray.forEach { valueString in
                    queryItems.append(URLQueryItem(name: key, value: valueString))
                }
            }
        }
        return queryItems
    }
}
