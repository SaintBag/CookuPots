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

struct RandomRecipe: Codable, RecipePresentable {
    let id: Int
    let title: String
    let image: String
    let analyzedInstructions: [RecipeInstructionsResponse]
}

struct RandomRecipesResponse: Codable {
    let recipes: [RandomRecipe]
}

struct Step: Codable {
    let number: Int
    let step: String
    let ingredients: [Ingredient]
    let equipment: [Equipment]?
}
struct Ingredient: Codable, Hashable {
    let id: Int
    let name: String
}

struct Equipment: Codable {
    let id: Int
    let name: String
    let temperature: [Temperature]?
}

struct Temperature: Codable {
    let number: Int
    let unit: String
}

class APIClient {

    let urlSession = URLSession.shared
    let spoonacularKey = "4414fe9b06284b2ba5ea75f7a9d9e9e1"
    let spoonacularKeyTwo = "219684950d1544638955eb8a1658d081"
    
    func downloadInstructions(forRecipeID recipeID: Int, onComplete: @escaping ([Step], Error?) -> Void) {
        let baseURL = "https://api.spoonacular.com"
        let endpoint = "/recipes/\(recipeID)/analyzedInstructions"
       
        let params = "?apiKey=\(spoonacularKeyTwo)"
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
                        let instructions = try JSONDecoder().decode([RecipeInstructionsResponse].self, from: data)
                        onComplete(instructions.first?.steps ?? [], nil)
                    
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
        let params = "?apiKey=\(spoonacularKeyTwo)&type=\(type.apiValue)&instructionsRequired=true&offset=25&number=100"
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
    
//    func downloadRecipiesInformacion(forRecipeID recipeID: Int, onComplete: @escaping ([Recipe], Error?) -> Void) {
//       
//        let baseURL = "https://api.spoonacular.com"
//        let endpoint = "/recipes/information"
//        let params = "?apiKey=\(spoonacularKeyTwo)"
//        guard let url = URL(string: baseURL + endpoint + params) else {
//            return
//        }
//        let request = URLRequest(url: url)
//        urlSession.dataTask(with: request) { (data, response, error) in
//            DispatchQueue.main.async {
//                if let error = error {
//                    onComplete([], error)
//                } else if let data = data {
//                
//                    do {
//                        let recipe = try JSONDecoder().decode(RecipiesResponse.self, from: data)
//                        onComplete(recipe.results, nil)
//                    
//                    } catch let jsonErr {
//                        onComplete([], jsonErr)
//                    }
//                }
//            }
//        }.resume()
//    }
    
    func downloadRandomRecipies(onComplete: @escaping ([RandomRecipe], Error?) -> Void) {
       
        let baseURL = "https://api.spoonacular.com"
        let endpoint = "/recipes/random"
        let params = "?apiKey=\(spoonacularKeyTwo)&number=5"
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
                        let result = try JSONDecoder().decode(RandomRecipesResponse.self, from: data)
                        onComplete(result.recipes, nil)
                    
                    } catch let jsonErr {
                        onComplete([], jsonErr)
                    }
                }
            }
        }.resume()
    }
}

