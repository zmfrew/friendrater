//
//  FriendDetailViewController.swift
//  FriendRater
//
//  Created by Zachary Frew on 7/7/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import UIKit

class FriendDetailViewController: UIViewController {

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        ratingSlider.minimumValueImage = UIImage(named: "ThumbsDown")
        ratingSlider.minimumValueImage = UIImage(named: "ThumbsUp")
    }
    
    // MARK: - Outlets
    @IBOutlet weak var friendNameTextField: UITextField!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingSlider: UISlider!
    
    // MARK: - Actions
    @IBAction func sliderDidChange(_ sender: UISlider) {
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    // MARK: - Properties
    
    // MARK: - Methods

}
