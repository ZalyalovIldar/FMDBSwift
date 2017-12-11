//
//  InfoButtonCollectionViewCell.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 19.10.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class InfoButtonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var infoButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    let attributes: [NSAttributedStringKey: Any] = {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let attributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey.paragraphStyle.rawValue): paragraph]
        return attributes
    }()
    
    func prepareCell(with type: InformationType, and user: User) {
        let photos = "фото"
        let videos = "видео"
        let audios = "аудио"
        
        switch type {
        case .friends:
            setTitle(with: user.friends, declinationWord: DeclinationWord.friend)
            break
        case .followers:
            setTitle(with: user.followers.count, declinationWord: DeclinationWord.follower)
            break
        case .groups:
            setTitle(with: user.groups, declinationWord: DeclinationWord.group)
            break
        case .photos:
            setTitle(with: user.photos.count, word: photos)
            break
        case .videos:
            setTitle(with: user.videos, word: videos)
            break
        case .audios:
            setTitle(with: user.audios, word: audios)
            break
        case .presents:
            setTitle(with: user.presents, declinationWord: DeclinationWord.present)
            break
        case .files:
            setTitle(with: user.files, declinationWord: DeclinationWord.file)
        }
    }
    
    private func setTitle(with count: Int, declinationWord: DeclinationWord) {
        let title = EndingWord.getCorrectEnding(with: count, and: declinationWord)
        let attrString = NSAttributedString(string: "\(count)" + "\n" + title, attributes: attributes)
        infoButton.setAttributedTitle(attrString, for: .normal)
    }
    
    private func setTitle(with count: Int, word: String) {
        let attrString = NSAttributedString(string: "\(count)" + "\n" + word, attributes: attributes)
        infoButton.setAttributedTitle(attrString, for: .normal)
    }

}
