//
//  MovieCoverCell.swift
//  CinemaInfo
//
//  Created by admin on 23/08/2021.
//

import UIKit
import SDWebImage

class MovieCoverCell: UICollectionViewCell {

    @IBOutlet weak var movieCoverCollectionView: UICollectionView!
    var presenter: MovieListPresenterProtocol?
    var parientVC: UIViewController?
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var movieList: [MovieVO]? = [] {
        didSet {
            if let _ = movieList {
                self.movieCoverCollectionView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movieCoverCollectionView.dataSource = self
        movieCoverCollectionView.delegate = self
        movieCoverCollectionView.register(CoverCell.self, forCellWithReuseIdentifier: CoverCell.identifier)
    }

}

extension MovieCoverCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: CoverCell.identifier, for: indexPath) as? CoverCell else {
            return UICollectionViewCell()
        }
        if let movie = movieList?[indexPath.row] {
            cell.poster = movie.backdrop_path
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = movieList?[indexPath.row] {
            presenter?.showMovieDetail(viewController: parientVC!, data: movie)
        }
    }
}

extension MovieCoverCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 10;
        return CGSize(width: width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
}

class CoverCell: UICollectionViewCell {
    
    let imageViewPoster : UIImageView = {
        let ui = UIImageView()
        ui.translatesAutoresizingMaskIntoConstraints = false
        ui.contentMode = UIView.ContentMode.scaleAspectFill
        return ui
    }()
    
    var poster: String? {
        didSet {
            if let img = poster {
                imageViewPoster.sd_setImage(with: URL(string: "\(API.BASE_IMG_URL)\(img)"), placeholderImage: UIImage(named: "placeholder_image"), options: SDWebImageOptions.progressiveLoad, completed: nil)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(imageViewPoster)
        imageViewPoster.translatesAutoresizingMaskIntoConstraints = false
        imageViewPoster.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        imageViewPoster.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        imageViewPoster.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        imageViewPoster.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        imageViewPoster.layer.masksToBounds = true
        imageViewPoster.layer.cornerRadius = 5
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
