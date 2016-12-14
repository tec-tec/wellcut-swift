//
//  Directory.swift
//  WhereToEat
//
//  Created by Ludovic Ollagnier on 14/12/2016.
//  Copyright © 2016 Ludovic Ollagnier. All rights reserved.
//

import Foundation

class Directory {
    
    private var restaurants: [Restaurant]
    
    init() {
        restaurants = []
    }
    
    func add(_ resto: Restaurant) {
        restaurants.append(resto)
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
