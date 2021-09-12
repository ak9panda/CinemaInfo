//
//  SearchedMoviesCell.swift
//  CinemaInfo
//
//  Created by admin on 28/08/2021.
//

import Foundation
import UIKit
import SDWebImage

class SearchedMovieCell: UITableViewCell {
    
    @IBOutlet weak var imbMovieCover: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var movie: MovieInfoResponse? {
        didSet {
            if let data = movie {
                if let img = data.poster_path {
                    imbMovieCover.sd_setImage(with: URL(string: "\(API.BASE_IMG_URL)\(img)"), placeholderImage: UIImage(named: "placeholder_image"), options: SDWebImageOptions.progressiveLoad, completed: nil)
                }
                
                lblMovieName.text = data.title ?? ""
                lblDescription.text = data.overview ?? ""
            }
        }
    }
    
    static var identifier : String {
        return String(describing: self)
    }
}
