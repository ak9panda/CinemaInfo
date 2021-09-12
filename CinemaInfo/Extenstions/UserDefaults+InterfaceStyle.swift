//
//  UserDefaults+InterfaceStyle.swift
//  CinemaInfo
//
//  Created by admin on 09/09/2021.
//

import Foundation
import UIKit

public extension UserDefaults {

    var overridedUserInterfaceStyle: UIUserInterfaceStyle {
        get {
            UIUserInterfaceStyle(rawValue: integer(forKey: #function)) ?? .unspecified
        }
        set {
            set(newValue.rawValue, forKey: #function)
        }
    }
}
