//
//  UIView+Extenstions.swift
//  CinemaInfo
//
//  Created by admin on 22/08/2021.
//

import Foundation
import UIKit

extension UIView {
    
    func addShadow() {
        let shadowSize: CGFloat = 20
        let contactRect = CGRect(x: -shadowSize, y: self.bounds.height - (shadowSize * 0.4), width: self.bounds.width + shadowSize * 2, height: shadowSize)
        self.layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.4
    }
    
    func addCornerRadius(size: CGSize) {
        let roundPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.allCorners], cornerRadii: size)
        let maskLayer = CAShapeLayer()
        maskLayer.path = roundPath.cgPath
        self.layer.mask = maskLayer
    }
    
    func setShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        self.layer.shadowRadius = 1
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
