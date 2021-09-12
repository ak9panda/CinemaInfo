//
//  LoadingIndicatorViewController.swift
//  CinemaInfo
//
//  Created by admin on 09/08/2021.
//

import UIKit

class LoadingIndicatorViewController: UIViewController {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadingIndicator.startAnimating()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        loadingIndicator.stopAnimating()
    }
    
    func showAlert(sourceView: UIViewController) {
        self.modalPresentationStyle = .overFullScreen
        sourceView.present(self, animated: false, completion: nil)
    }
    
    func hideAlert() {
        self.dismiss(animated: false, completion: nil)
    }
}

class Dialog {
    static func showAlert(viewController : UIViewController, title : String, message : String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alertVC, animated: true, completion: nil)
    }
}
