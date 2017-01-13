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
        if let mediumPrice = resto.mediumPrice {
            self.mediumPrice = Int16(mediumPrice)
        }
    }
    
    var restaurantStruct: Restaurant? {
        guard let name = name, let address = address else { return nil }
        return Restaurant(name: name, address: address)
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
