//
//  CoreDataStack.swift
//  snakeSecondTake
//
//  Created by Mikołaj Kamiński on 04/01/2019.
//  Copyright © 2019 Mikołaj Kamiński. All rights reserved.
//

import UIKit
import CoreData

class CoreDataStack: NSObject {
    
    func applicationDocumentsDirectory() {
        
        if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
            print(url.absoluteString)
        }
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("context saved!")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func deleteAllEntities(name: String) {
        
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        fetchRequest.includesPropertyValues = false
        do {
            let items = try context.fetch(fetchRequest) as! [NSManagedObject]
            
            for item in items {
                context.delete(item)
            }
            
        } catch {
            print("Deleting Error")
        }
    }
    
    static let sharedInstance = CoreDataStack()

}
