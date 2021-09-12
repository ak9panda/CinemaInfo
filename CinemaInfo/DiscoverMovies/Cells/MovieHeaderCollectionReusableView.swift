//
//  MovieHeaderCollectionReusableView.swift
//  CinemaInfo
//
//  Created by admin on 05/08/2021.
//

import UIKit

class MovieHeaderCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var lblHeader: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
