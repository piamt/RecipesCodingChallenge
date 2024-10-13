//
//  Recipe.swift
//  RecipesCodingChallenge
//
//  Created by Pia on 1/10/24.
//

import Foundation

public struct Recipes {
    let recipes: [Recipe]
    let nextLink: String
}

public struct Recipe: Hashable, Codable {
    let uri: String
    
    let label: String
    let image: String
    let ingredients: [Ingredient]?
}

public struct Ingredient: Hashable, Codable {
    let text: String?
    let quantity: Double?
    let measure: String?
    let food: String?
    let weight: Double?
}

extension Recipe {
    static let examples: [Recipe] = [
        .init(uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_76ad76f4914e9c6559463c2007f7060a",
              label: "Miso Soup Potato Chips Recipe",
              image: "https://edamam-product-images.s3.amazonaws.com/web-img/f43/f435b717a27bb7bd83f96315466060ad.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEF4aCXVzLWVhc3QtMSJIMEYCIQCBekh6KEgmE0scw%2Fpr452qpeEL7Iguj7e5ruC2bah9xQIhANGuvJR%2BQ99hqLbEp6LwOmpJIJujP7HSMROc3HYxasluKsIFCKf%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEQABoMMTg3MDE3MTUwOTg2IgzysAUqhQ9snqRq4lwqlgWJxYJcMpdncYk5P%2BP4e5q0yXA%2FzI92%2BWICq%2FJe3QLLEYxP0tDyDNesNQZ0hOVJaIZqbbbkpGEAqmF%2BK5W0LakuoSaGH6jOplwvnPSSdPKx3wAmuyLYW5jmJBubIRraqj4urc%2Be4OnZA%2F7N0hGcFLTtb9M%2FPY3INmNgqZrUth%2FQsKKdMEjtTuGp4dGafOnESvDAkXbAPHlv0mG%2FKQI2nKeVbLgH656%2Fd1gwq42wvyh4UNcf2wuvBMVuxWN6ERx%2FHORWjTjw5h1wIFXeI2pZCRV8MyKrXuoUp5lRLgLFKs%2FLSDRXq2cgoPVkMztHM2daXayl1WLKsdROD45s34vWBvTgb3tjw4yQA8Ky3Z%2BW0JFsNLSMVRS5%2F4Y6Kr6cVcqXWfsbg6UC3DCHsSmrQgJF4TI7wQbfRZ5Ss5enqOkubiZQUKlzZXKXyn3meBbjC3E6booIz%2B5ZvmYnF6gIgsSB0ZnxkDddlSJbciVard8DWDfmVG94z58dIrgeugHfmkCfSNWzILYqYDX%2FKxzkHuvPFuD5pOID0MPzrdOaNn3hwVzb0cOdrOf%2BQ%2FU3slbfb93%2FcHijRkV%2FkyclUYpI%2F3EuYbd6uxH7H7gkkomhBC5bh19Bn6hiffrj9TduSFuuTAPXPM3as3LbRtN8IgGTG68OpofX5HfFJTk3Kp%2B0ltRzhGJL1EEU6u5pEN2FXuDMj0Pi49jLh2MSEH1h4oXqL3nDDfgetqB8DBvOEgCPd1vGan0BZ9QD0E9jkmEvHCx67sKk%2FhTqdmcxbtlfMwwQwW2WlDPL5qryJR00gyzZPrk%2FcIRQlqx2WLZxRiDjZzpj3VZq%2BrDYwlHTPYWTV%2FnlB0wwQTE9K2Yn03j7hv2susmnl3H3IXn4a3GbMzCFpfW3BjqwAYMLngxul58tRhU5VxV4MyUd53qzQ9S6TBFXtW%2Ftoj3YyhJ771K8PYElDugHI1EuK8jrcL2i5u0LXwAt3VupGYu2qkY3Oqa5qAPd7oMblzOE4XYI7nD8ieY5StzHm9SpbsimI8jbwQE9NWi55RaX6ZHfZ%2Bax5KRVU%2FQXTjC%2BMjjtNmNcGGb1cttpTOfBlr3sGOsPt6QAmqNyumc7ABt5xsODQUNrkU9%2B%2BQDq41Fy9gqW&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20241002T150206Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFEFZHDPRS%2F20241002%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=fae98310e604a7a63826518f2fc7bffb7d616bc8a4629dbc40d51debe2598624",
              ingredients: [
                Ingredient(text: nil, quantity: 1.0, measure: "gram", food: "Potato Chips", weight: 1.272727),
                Ingredient(text: nil, quantity: 20, measure: "gram", food: "soup mix", weight: 20.0),
                Ingredient(text: nil, quantity: 10.0, measure: "sheet", food: "nori", weight: 26.0),
                Ingredient(text: nil, quantity: 0.0, measure: nil, food: "Kosher salt", weight: 0.28)
              ]),
        .init(uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_331cbf7fccfb49d8ad95bd03350628ca",
              label: "Carrot-Tomato Soup",
              image: "https://edamam-product-images.s3.amazonaws.com/web-img/696/69689df35faad8569fc05cbd4a067287.jpg?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEF4aCXVzLWVhc3QtMSJIMEYCIQCBekh6KEgmE0scw%2Fpr452qpeEL7Iguj7e5ruC2bah9xQIhANGuvJR%2BQ99hqLbEp6LwOmpJIJujP7HSMROc3HYxasluKsIFCKf%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEQABoMMTg3MDE3MTUwOTg2IgzysAUqhQ9snqRq4lwqlgWJxYJcMpdncYk5P%2BP4e5q0yXA%2FzI92%2BWICq%2FJe3QLLEYxP0tDyDNesNQZ0hOVJaIZqbbbkpGEAqmF%2BK5W0LakuoSaGH6jOplwvnPSSdPKx3wAmuyLYW5jmJBubIRraqj4urc%2Be4OnZA%2F7N0hGcFLTtb9M%2FPY3INmNgqZrUth%2FQsKKdMEjtTuGp4dGafOnESvDAkXbAPHlv0mG%2FKQI2nKeVbLgH656%2Fd1gwq42wvyh4UNcf2wuvBMVuxWN6ERx%2FHORWjTjw5h1wIFXeI2pZCRV8MyKrXuoUp5lRLgLFKs%2FLSDRXq2cgoPVkMztHM2daXayl1WLKsdROD45s34vWBvTgb3tjw4yQA8Ky3Z%2BW0JFsNLSMVRS5%2F4Y6Kr6cVcqXWfsbg6UC3DCHsSmrQgJF4TI7wQbfRZ5Ss5enqOkubiZQUKlzZXKXyn3meBbjC3E6booIz%2B5ZvmYnF6gIgsSB0ZnxkDddlSJbciVard8DWDfmVG94z58dIrgeugHfmkCfSNWzILYqYDX%2FKxzkHuvPFuD5pOID0MPzrdOaNn3hwVzb0cOdrOf%2BQ%2FU3slbfb93%2FcHijRkV%2FkyclUYpI%2F3EuYbd6uxH7H7gkkomhBC5bh19Bn6hiffrj9TduSFuuTAPXPM3as3LbRtN8IgGTG68OpofX5HfFJTk3Kp%2B0ltRzhGJL1EEU6u5pEN2FXuDMj0Pi49jLh2MSEH1h4oXqL3nDDfgetqB8DBvOEgCPd1vGan0BZ9QD0E9jkmEvHCx67sKk%2FhTqdmcxbtlfMwwQwW2WlDPL5qryJR00gyzZPrk%2FcIRQlqx2WLZxRiDjZzpj3VZq%2BrDYwlHTPYWTV%2FnlB0wwQTE9K2Yn03j7hv2susmnl3H3IXn4a3GbMzCFpfW3BjqwAYMLngxul58tRhU5VxV4MyUd53qzQ9S6TBFXtW%2Ftoj3YyhJ771K8PYElDugHI1EuK8jrcL2i5u0LXwAt3VupGYu2qkY3Oqa5qAPd7oMblzOE4XYI7nD8ieY5StzHm9SpbsimI8jbwQE9NWi55RaX6ZHfZ%2Bax5KRVU%2FQXTjC%2BMjjtNmNcGGb1cttpTOfBlr3sGOsPt6QAmqNyumc7ABt5xsODQUNrkU9%2B%2BQDq41Fy9gqW&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20241002T150206Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFEFZHDPRS%2F20241002%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=e5b84d490f6cdcdfbcccac5e5281b0e1e85abc19e0e07ad63e46902ad0e21292",
              ingredients: [
                Ingredient(text: nil, quantity: 3.0, measure: "<unit>", food: "carrots", weight: 183.0),
                Ingredient(text: nil, quantity: 2.0, measure: "<unit>", food: "tomatoes", weight: 207.5),
                Ingredient(text: nil, quantity: 0.5, measure: "teaspoon", food: "salt", weight: 3.0),
                Ingredient(text: nil, quantity: 0.5, measure: "teaspoon", food: "crushed red pepper", weight: 0.9),
                Ingredient(text: nil, quantity: 1.0, measure: "cup", food: "water", weight: 236.58)
              ])
    ]
}
