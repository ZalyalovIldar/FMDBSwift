//
//  NewsTableViewCell.swift
//  MyVK
//
//  Created by itisioslab on 19.10.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var imageInNewsImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    let radiusRoundCorner: CGFloat = 50
    @IBOutlet weak var textInNewsLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var repostButton: UIButton!
    @IBOutlet weak var newsImageView: UIImageView!
    
    @IBOutlet weak var constraintLikeToBottom: NSLayoutConstraint!
    @IBOutlet weak var constraintTextToLike: NSLayoutConstraint!
    @IBOutlet weak var constraintTextToImage: NSLayoutConstraint!
    @IBOutlet weak var constraintAvatarToText: NSLayoutConstraint!
    @IBOutlet weak var constraintAvatarToImage: NSLayoutConstraint!
    
   override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.text = ""
        surnameLabel.text = ""
        dataLabel.text = ""
        imageInNewsImageView.image = nil
        textInNewsLabel.text = ""
    }
    
    func prepare(with newsModel: News, and user: User) {
        let textIsEmpty = newsModel.text == nil
        
        if textIsEmpty, newsModel.image != nil {
            textInNewsLabel.isHidden = true
            newsImageView.isHidden = false
            constraintAvatarToText.priority = .defaultLow
            constraintAvatarToImage.priority = .defaultHigh
        }
        
        if !textIsEmpty, newsModel.image != nil {
            textInNewsLabel.isHidden = false
            constraintAvatarToImage.priority = .defaultLow
            constraintAvatarToText.priority = .defaultHigh
            
            newsImageView?.isHidden = false
            constraintTextToLike.priority = .defaultLow
            constraintTextToImage.priority = .defaultHigh
        }
        
        if !textIsEmpty, newsModel.image == nil {
            newsImageView?.isHidden = true
            textInNewsLabel.isHidden = false
            //constraintAvatarToText.priority = UILayoutPriority(rawValue: 999)
            constraintTextToImage.priority = .defaultLow
            constraintTextToLike.priority = .defaultHigh
            //constraintLikeToBottom.priority = .defaultLow
        }
        
        textInNewsLabel.text = newsModel.text
        newsImageView.image = newsModel.image
        nameLabel.text = user.name
        surnameLabel.text = user.surname
        dataLabel.text = newsModel.date
        likeButton.setTitle(newsModel.numberOfLikes, for: .normal)
        commentButton.setTitle(newsModel.numberOfComments, for: .normal)
        repostButton.setTitle(newsModel.numberOfReposts, for: .normal)
        avatarImageView.image = user.avatar
        avatarImageView.roundCorners([.bottomLeft, .bottomRight, .topLeft, .topRight], radius: radiusRoundCorner)
        
        layoutIfNeeded()
        setNeedsLayout()
    }
    
}
