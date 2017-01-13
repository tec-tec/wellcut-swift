//
//  CDRestaurant+CoreDataClass.swift
//  WhereToEat
//
//  Created by Ludovic Ollagnier on 12/01/2017.
//  Copyright © 2017 Ludovic Ollagnier. All rights reserved.
//

import Foundation
import CoreData

@objc(CDRestaurant)
public class CDRestaurant: NSManagedObject {

    convenience init(resto: Restaurant, context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = resto.name
        self.address = resto.address
        self.latitude = resto.latitude ?? 0
        self.longitude = resto.longitude ?? 0
        if let mediumPrice = resto.mediumPrice {
            self.mediumPrice = Int16(mediumPrice)
        }
    }
    
    var restaurantStruct: Restaurant? {
        guard let name = name, let address = address else { return nil }
        var resto = Restaurant(name: name, address: address)
        if latitude != 0 && longitude != 0 {
            resto.latitude = latitude
            resto.longitude = longitude
        }
        return resto
    }
    
/* We can use this subclass to add custom actions during object lifecycle
 
    public override func willSave() {
        super.willSave()
    }
    
    public override func prepareForDeletion() {
        super.prepareForDeletion()
    }
*/
    
}
