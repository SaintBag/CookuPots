//
//  SHIngredient+CoreDataProperties.swift
//  CookuPots
//
//  Created by Sebulla on 13/04/2022.
//
//

import Foundation
import CoreData


extension SHIngredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SHIngredient> {
        return NSFetchRequest<SHIngredient>(entityName: "SHIngredient")
    }

    @NSManaged public var name: String
    @NSManaged public var id: Int16

}

extension SHIngredient : Identifiable {

}
