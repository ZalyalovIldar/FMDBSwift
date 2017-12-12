//
//  InfoCollectionViewCell.swift
//  MyVK
//
//  Created by BLVCK on 26/10/2017.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import UIKit

class InfoCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var infoButton: UIButton!
    
    let friendsConst = "friends"
    let followersConst = "followers"
    let groupsConst = "groups"
    let photosConst = "photos"
    let videosConst = "videos"
    let audiosConst = "audios"
    let giftsConst = "gifts"
    let docsConst = "docs"
    let randomConst: UInt32 = 100
    
    func prepareCell(with type: InfoType) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        let color = UIColor.black
        
        switch type {
            
        case .friends:
            let friends = NSAttributedString(string: "\(arc4random_uniform(randomConst))" + "\n" + "\(friendsConst)",
                attributes: [NSAttributedStringKey.foregroundColor : color, NSAttributedStringKey.paragraphStyle:paragraphStyle])
            infoButton.setAttributedTitle(friends, for: .normal)
            
        case .followers:
            let followers = NSAttributedString(string: "\(arc4random_uniform(randomConst))" + "\n" + "\(followersConst)",
                attributes: [NSAttributedStringKey.foregroundColor : color, NSAttributedStringKey.paragraphStyle:paragraphStyle ])
            infoButton.setAttributedTitle(followers, for: .normal)

        case .groups:
            let groups = NSAttributedString(string: "\(arc4random_uniform(randomConst))" + "\n" + "\(groupsConst)",
                attributes: [NSAttributedStringKey.foregroundColor : color, NSAttributedStringKey.paragraphStyle:paragraphStyle])
            infoButton.setAttributedTitle(groups, for: .normal)

        case .photos:
            let photos = NSAttributedString(string: "\(arc4random_uniform(randomConst))" + "\n" + "\(photosConst)",
                attributes: [NSAttributedStringKey.foregroundColor : color, NSAttributedStringKey.paragraphStyle:paragraphStyle])
            infoButton.setAttributedTitle(photos, for: .normal)

        case .videos:
            let videos = NSAttributedString(string: "\(arc4random_uniform(randomConst))" + "\n" + "\(videosConst)",
                attributes: [NSAttributedStringKey.foregroundColor : color, NSAttributedStringKey.paragraphStyle:paragraphStyle])
            infoButton.setAttributedTitle(videos, for: .normal)

        case .audios:
            let audios = NSAttributedString(string: "\(arc4random_uniform(randomConst))" + "\n" + "\(audiosConst)",
                attributes: [NSAttributedStringKey.foregroundColor : color, NSAttributedStringKey.paragraphStyle:paragraphStyle])
            infoButton.setAttributedTitle(audios, for: .normal)

        case .gifts:
            let gifts = NSAttributedString(string: "\(arc4random_uniform(randomConst))" + "\n" + "\(giftsConst)",
                attributes: [NSAttributedStringKey.foregroundColor : color, NSAttributedStringKey.paragraphStyle:paragraphStyle])
            infoButton.setAttributedTitle(gifts, for: .normal)

        case .docs:
            let docs = NSAttributedString(string: "\(arc4random_uniform(randomConst))" + "\n" + "\(docsConst)",
                attributes: [NSAttributedStringKey.foregroundColor : color, NSAttributedStringKey.paragraphStyle:paragraphStyle ])
            infoButton.setAttributedTitle(docs, for: .normal)

        }
    }
}

