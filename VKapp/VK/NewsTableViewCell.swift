//
//  NewsTableViewCell.swift
//  VK
//
//  Created by Elina on 08/10/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var usersAvatarImage: UIImageView!
    @IBOutlet weak var usersName: UILabel!
    @IBOutlet weak var countOfLikes: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var newsTextView: UITextView!
    @IBOutlet weak var newsPicture: UIImageView!

    @IBOutlet weak var textToLikeConstraint: NSLayoutConstraint!
    @IBOutlet weak var textToPictureConstraint: NSLayoutConstraint!
    @IBOutlet weak var pictureToAvatarConstraint: NSLayoutConstraint!
    
    
    
    func prepare(with text: String, picture: UIImage, userName: String, usersAvatar: UIImage) {
        
        newsPicture.isHidden = false
        
        if text.isEmpty {
            newsTextView.isHidden = true
            textToPictureConstraint.priority = UILayoutPriorityDefaultLow
            pictureToAvatarConstraint.priority = UILayoutPriorityDefaultHigh
            
        } else {
            
            newsTextView.isHidden = false
            pictureToAvatarConstraint.priority = UILayoutPriorityDefaultLow
            textToPictureConstraint.priority = UILayoutPriorityDefaultHigh
            
        }
        
        newsTextView.text = text
        newsPicture.image = picture
        usersName.text = userName
        usersAvatarImage.image = usersAvatar
        
    }
    
    func prepare(with text: String, userName: String, usersAvatar: UIImage) {
        
        newsTextView.isHidden = false
        newsPicture.isHidden = true
        textToPictureConstraint.priority = UILayoutPriorityDefaultLow
        textToLikeConstraint.priority = UILayoutPriorityDefaultHigh
        
        newsTextView.text = text
        usersName.text = userName
        usersAvatarImage.image = usersAvatar
    }
}
