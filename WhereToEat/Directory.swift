//
//  Directory.swift
//  WhereToEat
//
//  Created by Ludovic Ollagnier on 14/12/2016.
//  Copyright © 2016 Ludovic Ollagnier. All rights reserved.
//

import Foundation

class Directory {
    
    static let shared = Directory()
    
    private var restaurants: [Restaurant]
    
    private init() {
        restaurants = []
    }
    
    func add(_ resto: Restaurant) {
        restaurants.append(resto)
        
        let notifCenter = NotificationCenter.default
        notifCenter.post(name: Notification.Name(Constants.NotificationNames.modelUpdated), object: nil)
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
