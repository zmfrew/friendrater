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
        ratingSlider.minimumValueImage = thumbsDownImage
        ratingSlider.maximumValueImage = thumbsUpImage
        ratingLabel.text = "\(0)"
        updateViews()
    }
    
    // MARK: - Outlets
    @IBOutlet weak var friendNameTextField: UITextField!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingSlider: UISlider!
    
    // MARK: - Actions
    @IBAction func sliderDidChange(_ sender: UISlider) {
        let sliderValue = Int(sender.value)
        ratingLabel.text = "\(sliderValue)"
        
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let friendName = friendNameTextField.text, !friendName.isEmpty, friendName != " ", let ratingLabelText = ratingLabel.text, let rating = Int(ratingLabelText) else { return }
        if let friend = friend {
            FriendController.shared.updateFriend(friend: friend, with: friendName, rating: rating)
        } else {
            FriendController.shared.createNewFriend(with: friendName, rating: rating)
        }
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Properties
    var friend: Friend?
    let thumbsDownImage = "👎".image()
    let thumbsUpImage = "👍".image()
    
    // MARK: - Methods
    func updateViews() {
        if let friend = friend {
            title = friend.name
            friendNameTextField.text = friend.name
            ratingLabel.text = "\(friend.rating)"
            ratingSlider.value = Float(friend.rating)
        }
    }
}

// MARK: - Convert Emojis into Images via Extension
extension String {
    func image() -> UIImage? {
        let size = CGSize(width: 40, height: 40)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.white.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 40)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

