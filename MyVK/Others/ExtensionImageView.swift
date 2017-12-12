//
//  ExtensionImageView.swift
//  MyVK
//
//  Created by itisioslab on 11.10.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
