//
//  APIClient.swift
//  CookuPots
//
//  Created by Sebulla on 24/03/2022.
//

import Foundation

class APIClient {
    
    let urlSession = URLSession.shared
    let spoonacularKey = "4414fe9b06284b2ba5ea75f7a9d9e9e1"
    
    func downloadRecipies(onComplete: @escaping (Data?, Error?) -> Void) {
        
        let baseURL = "https://api.spoonacular.com"
        let endpoint = "/recipes/complexSearch"
        let params = "?apiKey=\(spoonacularKey)"
        let url = URL(string: baseURL + endpoint + params)
        let request = URLRequest(url: url!)
        urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                onComplete(nil, error)
            } else if let data = data {
                onComplete(data, nil)
            }
        }.resume()
    }
}
