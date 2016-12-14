//
//  Restaurant.swift
//  WhereToEat
//
//  Created by Ludovic Ollagnier on 14/12/2016.
//  Copyright © 2016 Ludovic Ollagnier. All rights reserved.
//

import Foundation

struct Restaurant {
    
    enum Style {
        case japanese, burger, italian, chinese, vegan
    }
    
    enum Specificities {
        case vegan, organic, fast, takeAway
    }
    
    enum WeekDay {
        case Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
    }
    
    typealias OpeningHours = (open: Float, close: Float)
    
    let name: String
    let address: String
    let style: Style?
    var grade: Float?
    var mediumPrice: Int?
    var specificities: Set<Specificities>
    
    var openingHours: [WeekDay : OpeningHours]
    var lastVisit: Date?
    
    init(name: String, address: String, style: Style? = nil, grade: Float? = nil, mediumPrice: Int? = nil, specificities: Set<Specificities> = [], openingHours: [WeekDay : OpeningHours] = [:], lastVisit: Date? = nil) {
        self.name = name
        self.address = address
        self.style = style
        self.grade = grade
        self.mediumPrice = mediumPrice
        self.specificities = specificities
        self.openingHours = openingHours
        self.lastVisit = lastVisit
    }
}
