//
//  APIClient.swift
//  CookuPots
//
//  Created by Sebulla on 24/03/2022.
//

import Foundation

enum FoodCategory {
    case breakfast
    case soup
    case mainCourse
    case dessert
    
    var apiValue: String {
        switch self {
        
        case .breakfast:
            return "breakfast"
        case .soup:
            return "soup"
        case .mainCourse:
            return "main_course"
        case .dessert:
            return "dessert"
        }
    }
}

struct RecipiesResponse: Codable {
    let results: [Recipe]
    let offset: Int
    let number: Int
    let totalResults: Int
}

struct Recipe: Codable {
    let id: Int
    let title: String
    let image: String
}
// TODO: How to use 
struct RecipeInstructionsResponse: Codable {
    let name: String 
    let steps: [Step]
}

struct Step: Codable {
    let number: Int
    let step: String
    let ingredients: [Ingredients]
    let equipment: [Equipment]
}
struct Ingredients: Codable {
    let id: Int
    let name: String
}

struct Equipment: Codable {
    let id: Int
    let name: String
    let temperature: [Temperature]
}

struct Temperature: Codable {
    let number: Int
    let unit: String
}

class APIClient {

    let urlSession = URLSession.shared
    let spoonacularKey = "4414fe9b06284b2ba5ea75f7a9d9e9e1"
    
    func downloadInstructions(forRecipeID recipeID: Int, onComplete: @escaping ([Step], Error?) -> Void) {
        let baseURL = "https://api.spoonacular.com"
        let endpoint = "/recipes/\(recipeID)/analyzedInstructions"
       
        let params = "?apiKey=\(spoonacularKey)"
        guard let url = URL(string: baseURL + endpoint + params) else {
            return
        }
        let request = URLRequest(url: url)
        urlSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    onComplete([], error)
                } else if let data = data {
                
                    do {
                        let instructions = try JSONDecoder().decode(RecipeInstructionsResponse.self, from: data)
                        onComplete(instructions.steps, nil)
                    
                    } catch let jsonErr {
                        onComplete([], jsonErr)
                    }
                }
            }
        }.resume()
    }
    
    func downloadRecipies(ofType type: FoodCategory, onComplete: @escaping ([Recipe], Error?) -> Void) {
       
        let baseURL = "https://api.spoonacular.com"
        let endpoint = "/recipes/complexSearch"
        let params = "?apiKey=\(spoonacularKey)&type=\(type.apiValue)&instructionsRequired=true"
        guard let url = URL(string: baseURL + endpoint + params) else {
            return
        }
        let request = URLRequest(url: url)
        urlSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    onComplete([], error)
                } else if let data = data {
                
                    do {
                        let recipe = try JSONDecoder().decode(RecipiesResponse.self, from: data)
                        onComplete(recipe.results, nil)
                    
                    } catch let jsonErr {
                        onComplete([], jsonErr)
                    }
                }
            }
        }.resume()
    }
}

