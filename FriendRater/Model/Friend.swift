//
//  Friend.swift
//  FriendRater
//
//  Created by Zachary Frew on 7/7/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import Foundation

class Friend: Equatable, Codable {
    
    // MARK: - Properties
    let name: String
    var rating: Int
    
    // MARK: - Initializers
    init(name: String, rating: Int) {
        self.name = name
        self.rating = rating
    }

    // MARK: - Protocol Conformance
    static func == (lhs: Friend, rhs: Friend) -> Bool {
        return lhs.name == rhs.name && lhs.rating == rhs.rating
    }
}


