//
//  FoodCategory.swift
//  CookuPots
//
//  Created by Kamil Chołyk on 28/04/2022.
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
