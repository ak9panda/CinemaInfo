//
//  UIApplication+InterfaceStyle.swift
//  CinemaInfo
//
//  Created by admin on 09/09/2021.
//

import Foundation
import UIKit

public extension UIApplication {

    func override(_ userInterfaceStyle: UIUserInterfaceStyle) {
        if #available(iOS 13.0, *) {
            if supportsMultipleScenes {
                for connectedScene in connectedScenes {
                    if let scene = connectedScene as? UIWindowScene {
                        for window in scene.windows {
                            window.overrideUserInterfaceStyle = userInterfaceStyle
                        }
                    }
                }
            }
            else {
                for window in windows {
                    window.overrideUserInterfaceStyle = userInterfaceStyle
                }
            }
        }
    }
}
