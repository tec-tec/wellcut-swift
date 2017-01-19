//
//  Directory.swift
//  WhereToEat
//
//  Created by Ludovic Ollagnier on 14/12/2016.
//  Copyright © 2016 Ludovic Ollagnier. All rights reserved.
//

import Foundation
import CoreData

class Directory {
    
    static let shared = Directory()
    
    func add(_ resto: Restaurant) {
        _ = CDRestaurant(resto: resto, context: persistentContainer.viewContext)
        saveContext()
        
        let notifCenter = NotificationCenter.default
        notifCenter.post(name: Notification.Name(Constants.NotificationNames.modelUpdated), object: nil)
    }
    
    func remove(_ resto: Restaurant) {
        let fetchRequest: NSFetchRequest<CDRestaurant> = CDRestaurant.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@ && address == %@", resto.name, resto.address)
        guard let results = try? persistentContainer.viewContext.fetch(fetchRequest), results.count == 1 else { return }
        persistentContainer.viewContext.delete(results.first!)
        saveContext()
    }
    
    var allRestaurants: [Restaurant] {
        let fetchRequest: NSFetchRequest<CDRestaurant> = CDRestaurant.fetchRequest()
        guard let results = try? persistentContainer.viewContext.fetch(fetchRequest) else {
            return [Restaurant]()
        }
        
        var restos = [Restaurant]()
        for r in results {
            if let rStruct = r.restaurantStruct {
                restos.append(rStruct)
            }
        }
        return restos
    }
    
    var randomRestaurant: Restaurant? {
        let restos = allRestaurants
        guard !restos.isEmpty else { return nil }
        let index = Int(arc4random_uniform(UInt32(restos.count)))
        return restos[index]
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "WhereToEat")
        if let url = self.coreDataStorageDirectoryURL {
            let storeDesc = NSPersistentStoreDescription(url: url)
            container.persistentStoreDescriptions = [storeDesc]
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var coreDataStorageDirectoryURL: URL? {
        var url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.tectec.training.wellcut.wheretoeat")
        url?.appendPathComponent("/CoreData/Data.sqlite")
        return url
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
