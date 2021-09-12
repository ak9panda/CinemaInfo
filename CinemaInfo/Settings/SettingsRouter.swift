//
//  SettingsRouter.swift
//  CinemaInfo
//
//  Created by admin on 08/09/2021.
//

import Foundation
import UIKit

protocol SettingsRouterProtocol {
    static func createVC() -> UINavigationController
    func navigateToDarkModeViewController(viewController: UIViewController)
}

class SettingRouter: SettingsRouterProtocol {
    
    static func createVC() -> UINavigationController {
        let navVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: SettingsViewController.self)) as! UINavigationController
        
        let settingsVC = navVC.viewControllers[0] as! SettingsViewController
        
        let router = SettingRouter()
        settingsVC.router = router
        
        return navVC
    }
    
    func navigateToDarkModeViewController(viewController: UIViewController) {
        if let VC = viewController.storyboard?.instantiateViewController(withIdentifier: String(describing: DarkModeViewController.self)) as? DarkModeViewController {
            VC.dataDelegate = viewController.self as? SendDarkModeDataDelegate
            viewController.present(VC, animated: true, completion: nil)
        }
    }
}
