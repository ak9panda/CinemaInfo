//
//  SettingsViewController.swift
//  CinemaInfo
//
//  Created by admin on 08/09/2021.
//

import UIKit

class SettingsViewController: UIViewController, SendDarkModeDataDelegate {
    
    @IBOutlet weak var darkmodeView: UIView!
    @IBOutlet weak var lblDarkmodeStatus: UILabel!
    
    var router: SettingsRouterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        checkDarkModeToggle()
    }
    
    func setupView() {
        navigationItem.title = "Settings"
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "left_arrow")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "left_arrow")
        
        let tapDarkmode = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        darkmodeView.addGestureRecognizer(tapDarkmode)
    }
    
    func checkDarkModeToggle() {
        let interfaceStyle = UserDefaults.standard.overridedUserInterfaceStyle
        switch interfaceStyle {
        case .dark:
            darkmodeView.isUserInteractionEnabled = true
            lblDarkmodeStatus.text = "Enabled"
        case .light:
            darkmodeView.isUserInteractionEnabled = true
            lblDarkmodeStatus.text = "Disabled"
        default:
            darkmodeView.isUserInteractionEnabled = false
            lblDarkmodeStatus.text = "Unspecified"
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        router?.navigateToDarkModeViewController(viewController: self)
    }

    func sendDarkModeStatus(status: String) {
        self.lblDarkmodeStatus.text = status
    }
}
