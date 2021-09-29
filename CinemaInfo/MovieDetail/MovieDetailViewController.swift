//
//  MovieDeatilViewController.swift
//  CinemaInfo
//
//  Created by admin on 09/08/2021.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var btnWatchNow: UIButton!
    @IBOutlet weak var CVMovieCasts: UICollectionView!
    @IBOutlet weak var lblOriginalLang: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var btnButton: UIButton!
    @IBOutlet weak var lblGenre1: UILabel!
    @IBOutlet weak var lblGenre2: UILabel!
    @IBOutlet weak var lblGenre3: UILabel!
    @IBOutlet weak var lblGenre4: UILabel!
    
    let loadingVC = LoadingIndicatorViewController(nibName: "LoadingIndicatorViewController", bundle: nil)
    var bookmarkBtn = UIBarButtonItem()
    
    private var detailVM = MovieDetailViewModel()
    var movieId: Int = 0
    var bookmarkStatus: Bool = false
    var genres: [String]? {
        didSet {
            if let names = genres {
                print("genres count: \(names.count)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        detailVM.fetchMovieDetail(movieId: self.movieId)
        
        bindData()
    }
    
    func setupView() {
        bookmarkBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(onTouchBookmarkBtn(_:)))
        bookmarkStatus = detailVM.getBookmarkStatus(movieId: self.movieId)
        if #available(iOS 13.0, *) {
            bookmarkBtn.tintColor = .systemIndigo
        } else {
            bookmarkBtn.tintColor = UIColor.init(named: Colors.primary.rawValue)
        }
        bookmarkBtn.image = bookmarkStatus ? #imageLiteral(resourceName: "bookmark_filled") : #imageLiteral(resourceName: "bookmark_empty")
        self.navigationItem.rightBarButtonItem = bookmarkBtn
        btnButton.setCornerRadius(to: 10)
        imgPoster.layer.masksToBounds = true
        imgPoster.layer.cornerRadius = 5
        
        CVMovieCasts.register(MovieCastCell.self, forCellWithReuseIdentifier: MovieCastCell.identifier)
        CVMovieCasts.dataSource = self
        CVMovieCasts.delegate = self
    }
    
    func bindData() {
        detailVM.movieDetail.bind { [weak self] movie in
            DispatchQueue.main.async {
                if let detail = movie {
                    self?.lblTitle.text = detail.original_title
                    if let imgCover = detail.backdrop_path {
                        self?.imgCover.sd_setImage(with: URL(string: "\(API.BASE_IMG_URL)\(imgCover)"), placeholderImage: UIImage(named: "placeholder_image"), options: SDWebImageOptions.progressiveLoad, completed: nil)
                    }
                    if let imgPoster = detail.poster_path {
                        self?.imgPoster.sd_setImage(with: URL(string: "\(API.BASE_IMG_URL)\(imgPoster)"), placeholderImage: UIImage(named: "placeholder_image"), options: SDWebImageOptions.progressiveLoad, completed: nil)
                    }
                    let genres = detail.genres?.allObjects as! [MovieGenreVO]
                    self?.createLables(genre: genres)
                    self?.lblRating.text = String(detail.vote_average)
                    self?.lblOverview.text = detail.overview
                    self?.lblOriginalLang.text = " (\(detail.original_language?.uppercased() ?? "")) "
                    if let rDate = detail.release_date {
                        let dateComp = rDate.components(separatedBy: "-")
                        let releaseDate = " \(dateComp.last!)/\(dateComp[1])/\(dateComp.first!) "
                        self?.lblReleaseDate.text = releaseDate
                        self?.lblTitle.text! += " (\(dateComp.first!))"
                    }
                }
            }
        }
        
        detailVM.movieCasts.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.CVMovieCasts.reloadData()
            }
        }

    }
    
    private func createLables(genre: [MovieGenreVO]) {
        if genre.count == 4 {
            lblGenre4.text = " \(genre[3].name!) "
            lblGenre3.text = " \(genre[2].name!) "
            lblGenre2.text = " \(genre[1].name!) "
            lblGenre1.text = " \(genre[0].name!) "
        }else if genre.count == 3 {
            lblGenre3.text = " \(genre[2].name!) "
            lblGenre2.text = " \(genre[1].name!) "
            lblGenre1.text = " \(genre[0].name!) "
        }else if genre.count == 2 {
            lblGenre2.text = " \(genre[1].name!) "
            lblGenre1.text = " \(genre[0].name!) "
        }else if genre.count == 1 {
            lblGenre1.text = " \(genre[0].name!) "
        }
     }
    
    @objc func onTouchBookmarkBtn(_ sender: UIButton) {
        if bookmarkStatus {
            bookmarkBtn.image = detailVM.removeBookmark(movieId: self.movieId) ? #imageLiteral(resourceName: "bookmark_empty") : #imageLiteral(resourceName: "bookmark_filled")
        }else {
            bookmarkBtn.image = detailVM.saveBookmark(movieId: self.movieId) ? #imageLiteral(resourceName: "bookmark_filled") : #imageLiteral(resourceName: "bookmark_empty")
        }
    }
}

extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = detailVM.movieCasts.value?.count ?? 0
        return count > 10 ? 10 : count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCastCell.identifier, for: indexPath) as? MovieCastCell else {
            return UICollectionViewCell()
        }
        let cast = detailVM.movieCasts.value![indexPath.row]
        cell.castName = cast.name
        cell.poster = cast.profilePath
        
        return cell
    }
}

extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width / 3) - 20;
        
        return CGSize(width: width, height: width * 1.45)
    }
}

