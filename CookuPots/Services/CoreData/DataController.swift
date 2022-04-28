//
//  DataController.swift
//  CookuPots
//
//  Created by Sebulla on 13/04/2022.
//

import UIKit
import CoreData

protocol HasDataController {
    var dataController: DataControllerProtocol { get }
}

protocol DataControllerProtocol {
    var context: NSManagedObjectContext { get }
    
    func initalizeStack(completion: @escaping () -> Void)
    func insertIngredient(ingredient: Ingredient) throws
    func createIngredient(name: String)
    func delete(ingredient: SHIngredient) throws
}

final class DataController: DataControllerProtocol {
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    let persistentContainer = NSPersistentContainer(name: "Model")
    
    func initalizeStack(completion: @escaping () -> Void) {
        let description = NSPersistentStoreDescription()
        description.type = NSSQLiteStoreType
        
        if description.type == NSSQLiteStoreType {
            description.url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                .first?.appendingPathComponent("database")
        }
        persistentContainer.persistentStoreDescriptions = [description]
        persistentContainer.loadPersistentStores { description, error in
            
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
    
    func createIngredient(name: String) {
        let newIngredient = SHIngredient(context: context)
        newIngredient.name = name
        do {
            try context.save()
            
        } catch {
            print("problem with saving customIngredient")
        }
    }
    
    func isSaved(ingredient: Ingredient) -> Bool {
        // TODO: Check if database contains this ingredient/its name...
    }
    
    func delete(ingredient: SHIngredient) throws {
        let fetchRequest: NSFetchRequest<SHIngredient> = SHIngredient.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", ingredient.name) 
        do {
            let objects = try context.fetch(fetchRequest)
            for object in objects {
                context.delete(object)
            }
            try context.save()
        } catch _ {
            fatalError()
        }
    }
}
