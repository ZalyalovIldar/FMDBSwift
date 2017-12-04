//
//  BorderCreater.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 02.10.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

enum BorderPosition {
    case top
    case bottom
    case right
    case left
}

extension UIView {
    
    func createBorders(on position: BorderPosition, marginX: CGFloat) {
        let borderWidth = CGFloat(2.0)
        var borderLength = CGFloat(UIScreen.main.bounds.width - marginX * 2)
        let borderColor = UIColor(rgb: 0xdbd6d6).cgColor
        let borderMargin: CGFloat = 1.0
        let noneMargin:CGFloat = 0
        
        if self is UIScrollView {
            borderLength = UIScreen.main.bounds.height - marginX * 2
        }
        
        switch position {
        case .top:
            let borderTop = CALayer()
            borderTop.borderColor = borderColor
            borderTop.frame = CGRect(x: marginX, y: noneMargin, width: borderLength, height: borderMargin)
            borderTop.borderWidth = borderWidth
            
            self.layer.addSublayer(borderTop)
            self.layer.masksToBounds = true
            break
        case .bottom:
            let borderBottom = CALayer()
            borderBottom.borderColor = borderColor
            borderBottom.frame = CGRect(x: marginX, y: self.frame.height - borderMargin, width: borderLength, height: self.frame.height - borderMargin)
            borderBottom.borderWidth = borderWidth
            
            self.layer.addSublayer(borderBottom)
            self.layer.masksToBounds = true
            break
        case .right:
            let borderRight = CALayer()
            borderRight.borderColor = borderColor
            borderRight.frame = CGRect(x: self.frame.width - borderMargin, y: noneMargin, width: borderMargin, height: self.frame.height)
            borderRight.borderWidth = borderWidth
            
            self.layer.addSublayer(borderRight)
            break
        case .left:
            let borderLeft = CALayer()
            borderLeft.borderColor = borderColor
            borderLeft.frame = CGRect(x: noneMargin, y: noneMargin, width: borderMargin, height: self.frame.height)
            
            self.layer.addSublayer(borderLeft)
            break
        }
    }
    
}
