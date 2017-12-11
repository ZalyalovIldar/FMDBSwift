//
//  StringsHelper.swift
//  VK
//
//  Created by Elina on 16/10/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import Foundation
import UIKit

enum Identifiers: String {
    case mainInfoIdentifier = "mainInformationCell"
    case contactsIdentifier = "contactsCell"
    case careerIdentifier = "careerCell"
    case educationIdentifier = "educationCell"
    case interestsIdentifier = "interestsCell"
    case statusIdentifier = "statusCell"
    case giftsIdentifier = "giftsCell"
    case headerIdentifier = "headerCell"
    case labelIdentifier = "LabelCell"
    case cellIdentifier = "customCell"
    case newsCellIdentifier = "newsCell"
    case notesIdentifier = "newsSegue"
    case informationButtonIdentifier = "info"
    case photosCellIdentifier = "photosCell"
    case followersButtonIdentifier = "followersButton"
    case descriptionCellIdentifier = "descriptionCell"
    case giftsCellIdentifier = "giftsCollectionViewCell"
    case registrationCeellIdentifier = "registrationCell"
    case insertIdentifier = "insertIdentifier"
    case registrationIdentifier = "registrationIdentifier"
}

extension UINib {
    enum NibsNames: String {
        case mainInfoNibName = "CustomCellForMainInformation"
        case contactsNibName = "ContactsCell"
        case careerNibName = "CareerTableViewCell"
        case educationNibName = "EducationTableViewCell"
        case interestsNibName = "InterestsTableViewCell"
        case statusNibName = "StatusCustomTableViewCell"
        case giftsNibName = "GiftsTableViewCell"
        case headerNibName = "CustomHeaderCell"
        case followersCellNibName = "CustomFollowersTableViewCell"
        case newsCellNibName = "NewsTableViewCell"
        case photosCellNibName = "PhotosCollectionViewCell"
        case descriptionCellNibName = "DescriptionCollectionViewCell"
        case giftsCellNibName = "GiftsCollectionViewCell"
        case registrationCellNibName = "RegistrationTableViewCell"
        
        static let values = [mainInfoNibName, contactsNibName, careerNibName, educationNibName, interestsNibName, statusNibName, giftsNibName, headerNibName, followersCellNibName, newsCellNibName, photosCellNibName, descriptionCellNibName, giftsCellNibName, registrationCellNibName]
    }
    
    convenience init!(nibName: NibsNames) {
        self.init(nibName: nibName.rawValue, bundle: nil)
    }
}


extension UIImage {
    enum AssetName: String {
        case arrow = "Arrow"
        case commentIcon = "comment icon"
        case elina = "Elina"
        case elvira = "Elvira"
        case empty = "empty"
        case giftBaby = "gift baby"
        case giftBoy = "gift boy"
        case giftCat = "gift cat"
        case giftDog = "gift dog"
        case heart = "heart"
        case homeIcon = "home icon"
        case horizontalLine = "horizontal line"
        case information = "information"
        case iosIcon = "ios icon"
        case likeIcon = "like icon"
        case loudSpeakerIcon = "loud-speaker icon"
        case mapIcon = "map icon"
        case mobileIcon = "mobile icon"
        case nature = "nature"
        case noteIcon = "note icon"
        case phoneIcon = "phone icon"
        case point = "point"
        case selectedLikeIcon = "selected like icon"
        case threeLines = "Three lines"
        case threePointsForNewsIcon = "three points for news icon"
        case threePoints = "Three points"
        case verticalLine = "vertical line"
        case vkIcon = "vk icon"
        case zambezi = "zambezi"
        
        static let values = [arrow, commentIcon, elina, elvira, empty, giftBaby, giftBoy, giftCat, giftDog, heart, homeIcon, horizontalLine, information, iosIcon, likeIcon, loudSpeakerIcon, mapIcon, mobileIcon, nature, noteIcon, phoneIcon, point, selectedLikeIcon, threeLines, threePointsForNewsIcon, threePoints, verticalLine, vkIcon, zambezi]
    }
    
    convenience init!(assetName: AssetName) {
        self.init(named: assetName.rawValue)
    }
    
}
