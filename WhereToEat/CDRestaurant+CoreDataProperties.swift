//
//  CDRestaurant+CoreDataProperties.swift
//  WhereToEat
//
//  Created by Ludovic Ollagnier on 12/01/2017.
//  Copyright © 2017 Ludovic Ollagnier. All rights reserved.
//

import Foundation
import CoreData


extension CDRestaurant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDRestaurant> {
        return NSFetchRequest<CDRestaurant>(entityName: "Restaurant");
    }

    @NSManaged public var address: String?
    @NSManaged public var mediumPrice: Int16
    @NSManaged public var name: String?

}
