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
        saveToPersistentStore()
    }
    
    func updateFriend(friend: Friend, with name: String, rating: Int) {
        friend.name = name
        friend.rating = rating
        saveToPersistentStore()
    }
    
    func delete(friend: Friend) {
        if let friendToRemoveIndex = friends.index(of: friend) {
            friends.remove(at: friendToRemoveIndex)
        }
        saveToPersistentStore()
    }
    
    // MARK: - Persistence
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let playlistLocation = "friendrater.json"
        let fullURL = documentsDirectory.appendingPathComponent(playlistLocation)
        return fullURL
    }

    func saveToPersistentStore() {
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(friends)
            try data.write(to: fileURL())
        } catch let error {
            print("Error occured: \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistentStore() {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let friendsFromDecoder = try jsonDecoder.decode([Friend].self, from: data)
            friends = friendsFromDecoder
        } catch let error {
            print("Error occurred: \(error.localizedDescription)")
        }
    }
    
}
