//
//  DataController.swift
//  CookuPots
//
//  Created by Sebulla on 13/04/2022.
//

import UIKit
import CoreData

class DataController: NSObject {
    
    static let shared = DataController()
    private override init() {
        
    }
    
    var context: NSManagedObjectContext {
//        persistentContainer.viewContext.refreshAllObjects()
        return persistentContainer.viewContext
    }
    
    let persistentContainer = NSPersistentContainer(name: "Model")
    
    func initalizeStack(completion: @escaping () -> Void) {
        let description = NSPersistentStoreDescription()
        description.type = NSSQLiteStoreType // set desired type
        
        if description.type == NSSQLiteStoreType { //|| description.type == NSBinaryStoreType {
            // for persistence on local storage we need to set url
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
    
    func delete(ingredient: SHIngredient) throws {
        let fetchRequest: NSFetchRequest<SHIngredient> = SHIngredient.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", ingredient.name) //TODO: try with id
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
