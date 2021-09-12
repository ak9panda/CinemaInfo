//
//  MovieCastCell.swift
//  CinemaInfo
//
//  Created by admin on 28/08/2021.
//

import UIKit
import SDWebImage

class MovieCastCell: UICollectionViewCell {
    
    let imageViewPoster : UIImageView = {
        let ui = UIImageView()
        ui.translatesAutoresizingMaskIntoConstraints = false
        ui.contentMode = UIView.ContentMode.scaleAspectFill
        return ui
    }()
    
    let lblCastName: UILabel = {
        let ui = UILabel()
        ui.translatesAutoresizingMaskIntoConstraints = false
        ui.numberOfLines = 2
        ui.font = UIFont.systemFont(ofSize: 12)
        ui.textAlignment = .center
        return ui
    }()
    
    var poster: String? {
        didSet {
            if let img = poster {
                imageViewPoster.sd_setImage(with: URL(string: "\(API.BASE_IMG_URL)\(img)"), placeholderImage: UIImage(named: "placeholder_image"), options: SDWebImageOptions.progressiveLoad, completed: nil)
            }
        }
    }
    
    var castName: String? {
        didSet {
            if let name = castName {
                lblCastName.text = name
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let minimumSize = (frame.width > frame.height) ? frame.height : frame.width
        let minimumRatio = minimumSize * 0.7
        self.addSubview(imageViewPoster)
        // add constraints for imageview
        imageViewPoster.layer.masksToBounds = true
        imageViewPoster.heightAnchor.constraint(equalToConstant: CGFloat(minimumRatio)).isActive = true
        imageViewPoster.widthAnchor.constraint(equalToConstant: CGFloat(minimumRatio)).isActive = true
        imageViewPoster.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        imageViewPoster.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -5).isActive = true
        imageViewPoster.layer.cornerRadius = minimumRatio / 2
        
        self.addSubview(lblCastName)
        // add constraints for label
        lblCastName.topAnchor.constraint(equalTo: imageViewPoster.bottomAnchor, constant: 5).isActive = true
        lblCastName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        lblCastName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    static var identifier : String {
        return String(describing: self)
    }
}
