//
//  APIClient.swift
//  CookuPots
//
//  Created by Sebulla on 24/03/2022.
//

import Foundation

class APIClient {
    
    struct RecipiesResponse {
        let results: [Recipe]
        let offset: Int
        let number: Int
        let totalResults: Int
    }
    
    struct Recipe {
        let id: Int
        let title: String
        let image: String
    }
    
    let urlSession = URLSession.shared
    let spoonacularKey = "4414fe9b06284b2ba5ea75f7a9d9e9e1"
    
    func downloadRecipies(onComplete: @escaping ([Recipe], Error?) -> Void) {
        
        let baseURL = "https://api.spoonacular.com"
        let endpoint = "/recipes/complexSearch"
        let params = "?apiKey=\(spoonacularKey)&"
        let url = URL(string: baseURL + endpoint + params)
        let request = URLRequest(url: url!)
        urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                onComplete([], error)
            } else if let data = data {
                onComplete([], nil)
                // TODO: Use Codable to decode data
            }
        }.resume()
    }
}

