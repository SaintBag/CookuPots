//
//  URLParametersCreator.swift
//  CookuPots
//
//  Created by Kamil Chołyk on 28/04/2022.
//

import Foundation

struct URLParameter {
    let key: String
    let value: PresentableAsString
}

final class URLParametersCreator {
    func parametersInURL(parameters: [URLParameter]) -> String {
        var parametersString = "?"
        for pair in parameters {
            parametersString.append(contentsOf: "\(pair.key)=\(pair.value.stringValue)&")
        }
        _ = parametersString.removeLast()
        
        return parametersString
    }
}
