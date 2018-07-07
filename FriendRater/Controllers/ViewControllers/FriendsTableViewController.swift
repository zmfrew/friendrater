//
//  FriendsTableViewController.swift
//  FriendRater
//
//  Created by Zachary Frew on 7/7/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Outlets
    
    // MARK: - Actions
    
    // MARK: - Properties

    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FriendController.shared.friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath)
        let friendToDisplay = FriendController.shared.friends[indexPath.row]
        cell.textLabel?.text = friendToDisplay.name
        cell.detailTextLabel?.text = "Rating: \(friendToDisplay.rating)"
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let friendToDelete = FriendController.shared.friends[indexPath.row]
            FriendController.shared.delete(friend: friendToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }  
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
