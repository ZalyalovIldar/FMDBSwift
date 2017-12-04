//
//  WallTableViewCell.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 02.10.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsTextLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet var newsActionButtons: [UIButton]!
    @IBOutlet var actionCountLabels: [UILabel]!
    
    @IBOutlet weak var avatarToImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var avatarToTextConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var textToImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var textToLikeConstraint: NSLayoutConstraint!
    
    private let likeCountLabel = 0
    private let commentCountLabel = 1
    private let repostCountLabel = 2
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.roundCorners()
        
        for newsActionButton in newsActionButtons {
            if let originalImage = newsActionButton.image(for: .normal) {
                let tintedImage = originalImage.withRenderingMode(.alwaysTemplate)
                newsActionButton.setImage(tintedImage, for: .normal)
                newsActionButton.tintColor = .darkGray
            }
        }
        
    }
    
    func prepareCell(with news: News, from user: User, number: Int) {
        prepareConstraints(with: news)
        
        print("\(number)) avatarToImage: \(avatarToImageConstraint.priority.rawValue) and avatarToText: \(avatarToTextConstraint.priority.rawValue)")
        
        avatarImageView.image = user.profileImage
        nameLabel.text = "\(user.name) \(user.surname)"
        newsTextLabel.text = news.text
        
        if let newsImage = news.image {
            newsImageView.image = newsImage
        }
        
        actionCountLabels[likeCountLabel].text = String(news.likeCount)
        actionCountLabels[commentCountLabel].text = String(news.commentCount)
        actionCountLabels[repostCountLabel].text = String(news.respostCount)
    }
    
    private func prepareConstraints(with news: News) {
        if news.text.isEmpty {
            newsTextLabel.isHidden = true
            avatarToTextConstraint.priority = .defaultLow
            avatarToImageConstraint.priority = .defaultHigh
        } else {
            newsTextLabel.isHidden = false
            avatarToTextConstraint.priority = .defaultHigh
            avatarToImageConstraint.priority = .defaultLow
        }
        
        if !news.text.isEmpty, news.image == nil {
            newsImageView.isHidden = true
            textToImageConstraint.priority = .defaultLow
            textToLikeConstraint.priority = .defaultHigh
        } else {
            newsImageView.isHidden = false
            textToImageConstraint.priority = .defaultHigh
            textToLikeConstraint.priority = .defaultLow
        }
    }
    
}
