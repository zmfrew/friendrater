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
        // Load data
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Friends"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        FriendController.shared.loadFromPersistentStore()
        searchController.searchBar.scopeButtonTitles = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        searchController.searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Outlets
    @IBOutlet weak var nameSearchBar: UISearchBar!
    
    // MARK: - Actions
    
    // MARK: - Properties
    let searchController = UISearchController(searchResultsController: nil)
    var filteredFriends = [Friend]()
    
    // MARK: - Instance Methods
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredFriends = FriendController.shared.friends.filter({( friend : Friend ) -> Bool in
            let doesRatingMatch = (scope == "All") || (String(friend.rating) == scope)
            if searchBarIsEmpty() {
                return doesRatingMatch
            } else {
            return friend.name.lowercased().contains(searchText.lowercased())
            }
        })
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }
    
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredFriends.count
        }
        return FriendController.shared.friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath)
        let friend: Friend
        if isFiltering() {
            friend = filteredFriends[indexPath.row]
        } else {
            friend = FriendController.shared.friends[indexPath.row]
        }
        cell.textLabel?.text = friend.name
        cell.detailTextLabel?.text = "Rating: \(friend.rating)"
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let friendToDelete = FriendController.shared.friends[indexPath.row]
            guard let filteredFriendToDelete = filteredFriends.index(of: friendToDelete) else { return }
            filteredFriends.removeFirst(filteredFriendToDelete)
            FriendController.shared.delete(friend: friendToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToFriendDetail" {
            guard let destinationVC = segue.destination as? FriendDetailViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
            let friendToEdit: Friend
            if isFiltering() {
                friendToEdit = filteredFriends[indexPath.row]
            } else {
                friendToEdit = FriendController.shared.friends[indexPath.row]
            }
            destinationVC.friend = friendToEdit
        }
    }

}

// MARK: - Implement Search Function
extension FriendsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

// MARK: - UISearchBar Delegate
extension FriendsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
