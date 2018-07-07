//
//  FriendController.swift
//  FriendRater
//
//  Created by Zachary Frew on 7/7/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import Foundation

class FriendController {
    
    // MARK: - Singleton
    static let shared = FriendController()
    
    // MARK: - Datasource (Source of Truth)
    var friends: [Friend] = []
    
    // MARK: - CRUD Methods
    func createNewFriend(with name: String, rating: Int) {
        let newFriend = Friend(name: name, rating: rating)
        friends.append(newFriend)
        // Save to persistence
    }
    
    func updateFriend(friend: Friend, with rating: Int) {
        friend.rating = rating
        // Save to persistence
    }
    
    func delete(friend: Friend) {
        if let friendToRemoveIndex = friends.index(of: friend) {
            friends.remove(at: friendToRemoveIndex)
        }
    }
    
}
