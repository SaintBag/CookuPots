//
//  Recipe.swift
//  CookuPots
//
//  Created by Kamil Chołyk on 28/04/2022.
//

import Foundation

protocol RecipePresentable {
    var id: Int { get }
    var title: String { get }
    var image: String { get }
}

struct Recipe: Codable, RecipePresentable {
    let id: Int
    let title: String
    let image: String
}

struct RecipeInstructionsResponse: Codable {
    let name: String
    let steps: [Step]
}

struct RecipiesResponse: Codable {
    let results: [Recipe]
    let offset: Int
    let number: Int
    let totalResults: Int
}

struct RandomRecipesResponse: Codable {
    let recipes: [RandomRecipe]
}

struct RandomRecipe: Codable, RecipePresentable {
    let id: Int
    let title: String
    let image: String
    let analyzedInstructions: [RecipeInstructionsResponse]
}
