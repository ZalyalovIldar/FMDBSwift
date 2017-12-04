//
//  Storable.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 27.11.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import Foundation

protocol Storable: NSCoding {
    var id: Int { get set }
}
