//
//  URLParametersCreator.swift
//  CookuPots
//
//  Created by Kamil Chołyk on 28/04/2022.
//

import Foundation

final class URLParametersCreator {
    func parametersInURL(parameters: [String: String]) -> String {
        var parametersString = "?"
        for pair in parameters {
            parametersString.append(contentsOf: "\(pair.key)=\(pair.value)&")
        }
        _ = parametersString.removeLast()
        
        return parametersString
    }
}
