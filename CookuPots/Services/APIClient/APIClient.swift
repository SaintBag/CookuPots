//
//  APIClient.swift
//  CookuPots
//
//  Created by Sebulla on 24/03/2022.
//

import Foundation

protocol HasAPIClient {
    var apiClient: APIClientProtocol { get }
}

protocol APIClientProtocol {
    func downloadInstructions(forRecipeID recipeID: Int, onComplete: @escaping ([Step], Error?) -> Void)
    func downloadRecipies(ofType type: FoodCategory, onComplete: @escaping ([Recipe], Error?) -> Void)
    func downloadRandomRecipies(onComplete: @escaping ([RandomRecipe], Error?) -> Void)
}

class APIClient: APIClientProtocol {
    
    private let urlParametersCreator: URLParametersCreator
    private let urlSession = URLSession.shared
    private let baseURL = "https://api.spoonacular.com"
    private let spoonacularKey = "4414fe9b06284b2ba5ea75f7a9d9e9e1" // cocoapods-keys
    private let spoonacularKeyTwo = "219684950d1544638955eb8a1658d081"
    
    init(urlParametersCreator: URLParametersCreator) {
        self.urlParametersCreator = urlParametersCreator
    }
    
    func downloadInstructions(forRecipeID recipeID: Int, onComplete: @escaping ([Step], Error?) -> Void) {
        let endpoint = "/recipes/\(recipeID)/analyzedInstructions"
        let parameters: [URLParameter] = [
            .init(key: "apiKey", value: spoonacularKey)
        ]
        
        let parametersInURL = urlParametersCreator.parametersInURL(parameters: parameters)
        guard let url = URL(string: baseURL + endpoint + parametersInURL ) else {
            onComplete([], NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Couldn't create URL"]))
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
        let endpoint = "/recipes/complexSearch"
        let parameters: [URLParameter] = [
            .init(key: "apiKey", value: spoonacularKey),
            .init(key: "type", value: type.apiValue),
            .init(key: "instructionsRequired", value: "true"),
            .init(key: "offset", value: 25),
            .init(key: "number", value: 100),
        ]
        let parametersInURL = urlParametersCreator.parametersInURL(parameters: parameters)
        guard let url = URL(string: baseURL + endpoint + parametersInURL) else {
            onComplete([], NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Couldn't create URL"]))
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
    
    func downloadRandomRecipies(onComplete: @escaping ([RandomRecipe], Error?) -> Void) {
       
        let endpoint = "/recipes/random"
        let parameters: [URLParameter] = [
            .init(key: "apiKey", value: spoonacularKey),
            .init(key: "number", value: 5)
        ]
        
        let parameterInURL = urlParametersCreator.parametersInURL(parameters: parameters)
        
        guard let url = URL(string: baseURL + endpoint + parameterInURL) else {
            onComplete([], NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Couldn't create URL"]))
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
                        onComplete((result.recipes), nil)
                    
                    } catch let jsonErr {
                        onComplete([], jsonErr)
                        print(String.init(data: data, encoding: .utf8)!)
                    }
                }
            }
        }.resume()
    }
}

