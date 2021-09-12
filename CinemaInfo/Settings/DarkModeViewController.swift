//
//  DarkModeViewController.swift
//  CinemaInfo
//
//  Created by admin on 08/09/2021.
//

import UIKit

protocol SendDarkModeDataDelegate {
    func sendDarkModeStatus(status: String)
}

class DarkModeViewController: UIViewController {
    
    @IBOutlet weak var darkModeToggle: UISwitch!
    @IBOutlet weak var btnSystem: UIView!
    @IBOutlet weak var btnManual: UIView!
    @IBOutlet weak var imgSystemCheck: UIImageView!
    @IBOutlet weak var imgManualCheck: UIImageView!
    
    var dataDelegate: SendDarkModeDataDelegate? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        checkDarkModeToggle()
    }
    
    func initView() {
        btnSystem.isUserInteractionEnabled = true
        btnManual.isUserInteractionEnabled = true
        
        let tapSystem = UITapGestureRecognizer(target: self, action: #selector(self.tapSystemBtn(_:)))
        btnSystem.addGestureRecognizer(tapSystem)
        let tapManual = UITapGestureRecognizer(target: self, action: #selector(self.tapManualBtn(_:)))
        btnManual.addGestureRecognizer(tapManual)
    }
    
    func checkDarkModeToggle() {
        
        let systemInterfaceStyle = UIScreen.main.traitCollection.userInterfaceStyle
        let interfaceStyle = UserDefaults.standard.overridedUserInterfaceStyle
        
        if systemInterfaceStyle == .unspecified || interfaceStyle == .unspecified {
            darkModeToggle.isEnabled = false
        }else if systemInterfaceStyle == .light && interfaceStyle == .light {
            darkModeToggle.isOn = false
        }else {
            darkModeToggle.isOn = true
            if systemInterfaceStyle == .dark {
                switchCheck(on: true)
            }else {
                switchCheck(on: false)
            }
        }
    }

    @IBAction func onTouchDoneBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTouchToggle(_ sender: Any) {
        let toggle = sender as! UISwitch
        btnSystem.isUserInteractionEnabled = toggle.isOn
        btnManual.isUserInteractionEnabled = toggle.isOn
        
        if #available(iOS 13.0, *) {
            btnSystem.backgroundColor = toggle.isOn ? UIColor.init(named: Colors.secondaryBackground.rawValue) : .systemGray4
            btnManual.backgroundColor = toggle.isOn ? UIColor.init(named: Colors.secondaryBackground.rawValue) : .systemGray4
        } else {
            btnSystem.backgroundColor = .white
            btnManual.backgroundColor = .white
        }
        
        if toggle.isOn {
            setUserInterfaceStyle(value: 2)
            imgManualCheck.image = UIImage.init(named: "check")
        }else {
            setUserInterfaceStyle(value: 1)
            imgManualCheck.image = nil
            imgSystemCheck.image = nil
        }
    }
    
    func setUserInterfaceStyle(value: Int) {
        guard let style = UIUserInterfaceStyle(rawValue: value) else {
            return
        }
        UIApplication.shared.override(style)
        UserDefaults.standard.overridedUserInterfaceStyle = style
    }
    
    @objc func tapSystemBtn(_ sender: UITapGestureRecognizer) {
        if UIScreen.main.traitCollection.userInterfaceStyle == .dark {
            setUserInterfaceStyle(value: 2)
        } else {
            setUserInterfaceStyle(value: 1)
        }
        switchCheck(on: true)
        if dataDelegate != nil {
            self.dataDelegate?.sendDarkModeStatus(status: "System")
        }
    }
    
    @objc func tapManualBtn(_ sender: UITapGestureRecognizer) {
        setUserInterfaceStyle(value: 2)
        switchCheck(on: false)
        if dataDelegate != nil {
            self.dataDelegate?.sendDarkModeStatus(status: "Manual")
        }
    }
    
    // check which to show check image
    func switchCheck(on status: Bool) {
        if status {
            imgSystemCheck.image = UIImage.init(named: "check")
            imgManualCheck.image = nil
        }else {
            imgSystemCheck.image = nil
            imgManualCheck.image = UIImage.init(named: "check")
        }
    }
}
