//
//  DiningHalls.swift
//  L4Starter
//
//  Created by Karnav Raval on 2020-08-27.
//  Copyright © 2020 Yana Sang. All rights reserved.
//

import Foundation

enum Rating {
    case bad, okay, good, great
}

class DiningHall {
    
    var name: String
    var rating: Rating
    var isFavorite: Bool
    
    init(name: String, rating: Rating, isFavorite: Bool) {
        self.name = name
        self.rating = rating
        self.isFavorite = isFavorite
    }
    
    func getRatingString() -> String {
        switch rating {
        case .bad:
            return "Bad"
        case .okay:
            return "Okay"
        case .good:
            return "Good"
        case .great:
            return "Great"
        }
    }
    
}
