//
//  DataController.swift
//  CookuPots
//
//  Created by Sebulla on 13/04/2022.
//

import UIKit
import CoreData

class DataController {
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    let persistentContainer = NSPersistentContainer(name: "Model")
    
    func initalizeStack(completion: @escaping () -> Void) {
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType // set desired type
        
        if description.type == NSSQLiteStoreType || description.type == NSBinaryStoreType {
            // for persistence on local storage we need to set url
            description.url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                .first?.appendingPathComponent("database")
        }
        self.persistentContainer.persistentStoreDescriptions = [description]
        self.persistentContainer.loadPersistentStores { description, error in
           
            if let error = error {
                print("could not load store \(error.localizedDescription)")
                return
            }
            
            print("store loaded")
            completion()
        }
    }
    
    func insertIngredient(ingredient: Ingredient) throws {
        let shIngredient = SHIngredient(context: self.context)
        shIngredient.name = ingredient.name
        
        self.context.insert(shIngredient)
        try self.context.save()
    }
    
    func fetchIngredients() throws -> [Ingredient] {
        let ingredients = try self.context.fetch(SHIngredient.fetchRequest() as NSFetchRequest<SHIngredient>)
        return ingredients.map {
            let id = $0.id
            let name = $0.name
            return Ingredient(id: Int(id), name: name)
        }
    }
}
