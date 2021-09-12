//
//  UIButton+Extension.swift
//  CinemaInfo
//
//  Created by admin on 23/08/2021.
//

import Foundation
import UIKit

extension UIButton {
    // set corner radius by value
    func setCornerRadius(to value: Int) {
        let roundPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: CGFloat(value))
        let maskLayer = CAShapeLayer()
        maskLayer.path = roundPath.cgPath
        self.layer.mask = maskLayer
    }
    
//    func addShadow() {
//        self.layer.masksToBounds = false
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOpacity = 1.0
//        self.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
//        self.layer.shadowRadius = 1
//        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//        self.layer.shouldRasterize = true
//        self.layer.rasterizationScale = UIScreen.main.scale
//    }
}
