//
//  CoreDataManager.swift
//  Storyboarding
//
//  Created by Stephen Ouyang on 5/30/19.
//  Copyright © 2019 Stephen Ouyang. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    // Core Data singleton
    static let sharedManager = CoreDataManager()
    private init() {}
    
    // create NSPersistentContainer
    lazy var persistentContainer: NSPersistentContainer = {
        
        // create container instance
        let container = NSPersistentContainer(name: "Storyboarding")
        
        // Load stores from the storeDescriptions property that have not already been successfully added to the container.
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            // handle errors
            if let error = error as NSError? {
                fatalError("unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // create instance of context, an object that manages all the saved data
    lazy var context: NSManagedObjectContext = {
       return persistentContainer.viewContext
    }()
    
    // save current data into persistent store
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                if let error = error as NSError? {
                    fatalError("unresolved error \(error), \(error.userInfo)")
                }
            }
        }
    }
    
    // fetch all storyboards from Core Data
    func fetchStoryboards() -> [Storyboard]? {
        
        // create array to hold storyboard data fetched
        var allBoards: [Storyboard] = []
        
        // create fetch request
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Storyboard")
        
        // try to fetch items
        do {
           allBoards = try context.fetch(fetchRequest) as! [Storyboard]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        // return items
        return allBoards
    }
    
    // fetch single storyboard from Core Data
    func fetchStoryboard(boardName: String) -> NSManagedObject? {
                
        var storyboardArr: [Storyboard] = []
        var storyboard: Storyboard?
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Storyboard")
        fetchRequest.predicate = NSPredicate(format: "title = %@", boardName)
        
        do {
            storyboardArr = try context.fetch(fetchRequest) as! [Storyboard]
            if !storyboardArr.isEmpty {
                storyboard = storyboardArr.first
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return storyboard
    }
    
    // create single storyboard and save it into Core Data
    func createStoryboard(storyName: String) {
        
        // create storyboard entity
        let entity = NSEntityDescription.entity(forEntityName: "Storyboard", in: context)
        guard let unwrappedEntity = entity else {
            print("FAILURE: entity unable to be unwrapped: \(String(describing: entity))")
            return 
        }
        
        // create storyboard object using entity
        let object = NSManagedObject(entity: unwrappedEntity, insertInto: context)
        object.setValue(storyName, forKey: "title")
        
//        print(object.objectID)
        
        // save
        saveContext()
    }
    
    func fetchAllElements() -> [Elements]? {
        var allElements: [Elements] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Elements")
        do {
           allElements = try context.fetch(fetchRequest) as! [Elements]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return allElements
    }
    
    // create single element and save to Core Data
    func createElement(type: String, content: String, storyboard: Storyboard) {
        
        let entity = NSEntityDescription.entity(forEntityName: "Elements", in: context)
        guard let unwrappedEntity = entity else {
            print("FAILURE: entity unable to be unwrapped: \(String(describing: entity))")
            return
        }
        
        let object = NSManagedObject(entity: unwrappedEntity, insertInto: context)
        object.setValue(type, forKey: "type")
        object.setValue(content, forKey: "content")
        storyboard.addToElements(object as! Elements)
        
        saveContext()
    }
    
    // remove any single item from Core Data
    func removeItem( objectID: NSManagedObjectID ) {
        let obj = context.object(with: objectID)
        context.delete(obj)
    }
}
