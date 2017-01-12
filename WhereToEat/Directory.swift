//
//  Directory.swift
//  WhereToEat
//
//  Created by Ludovic Ollagnier on 14/12/2016.
//  Copyright © 2016 Ludovic Ollagnier. All rights reserved.
//

import Foundation
import CloudKit

class Directory {
    
    static let shared = Directory()
    
    private var restaurants: [Restaurant]
    
    private init() {
        
        restaurants = []

        let container = CKContainer.default()
        let pubDB = container.publicCloudDatabase
        
        let pred = NSPredicate(value: true)
        let query = CKQuery(recordType: "Restaurant", predicate: pred)
        pubDB.perform(query, inZoneWith: nil) { (records, error) in
            if let e = error {
                //traiterbl'erreur
            } else {
                guard let rec = records else { return }
                for r in rec {
                    let resto = Restaurant(name: r["name"] as! String, address: r["address"] as! String)
                    self.restaurants.append(resto)
                }
                let notifCenter = NotificationCenter.default
                notifCenter.post(name: Notification.Name(Constants.NotificationNames.modelUpdated), object: nil)
            }
        }
    }
    
    func add(_ resto: Restaurant) {
        restaurants.append(resto)
        
        let notifCenter = NotificationCenter.default
        notifCenter.post(name: Notification.Name(Constants.NotificationNames.modelUpdated), object: nil)
        
        let container = CKContainer.default()
        let pubDB = container.publicCloudDatabase
        
        let restoRecord = CKRecord(recordType: "Restaurant")
        restoRecord["name"] = resto.name as CKRecordValue?
        restoRecord["address"] = resto.address as CKRecordValue?
        restoRecord["mediumPrice"] = resto.mediumPrice as CKRecordValue?
        
        pubDB.save(restoRecord) { (record, error) in
            if let e = error {
                //Traiter l'erreur
            } else {
                print("Pushed to iCloud")
            }
        }
    }
    
    func remove(_ resto: Restaurant) {
        guard let index = restaurants.index(of: resto) else { return }
        restaurants.remove(at: index)
    }
    
    var allRestaurants: [Restaurant] {
        return restaurants
    }
    
    var randomRestaurant: Restaurant? {
        guard !restaurants.isEmpty else { return nil }
        let index = Int(arc4random_uniform(UInt32(restaurants.count)))
        return restaurants[index]
    }
}
