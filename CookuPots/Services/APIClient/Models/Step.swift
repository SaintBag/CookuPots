//
//  Step.swift
//  CookuPots
//
//  Created by Kamil Chołyk on 28/04/2022.
//

import Foundation

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
