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
    @IBOutlet weak var genreVStuckView: UIStackView!
    @IBOutlet weak var VStuckHeight: NSLayoutConstraint!
    
    let loadingVC = LoadingIndicatorViewController(nibName: "LoadingIndicatorViewController", bundle: nil)
    var bookmarkBtn = UIBarButtonItem()
    
    var presenter: MovieDetailPresenterProtocol?
    var movieDetail: MovieVO?
    var movieCasts: [Cast]? {
        didSet {
            if let _ = movieCasts {
                CVMovieCasts.reloadData()
            }
        }
    }
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
        initView()
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func setupView() {
        let presenter = MovieDetailPresenter()
        let interactor = MovieDetailInteractor()
        let router = MovieDetailRouter()
        let dataManager = MovieDetailDataManager()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = self
        
        interactor.preseanter = presenter
        interactor.dataManager = dataManager
        
        self.presenter = presenter
    }
    
    func initView() {
        bookmarkBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(onTouchBookmarkBtn(_:)))
        bookmarkStatus = presenter?.getBookmarkStatus(movieId: self.movieId) ?? false
        bookmarkBtn.tintColor = .purple
        bookmarkBtn.image = bookmarkStatus ? #imageLiteral(resourceName: "bookmark_filled") : #imageLiteral(resourceName: "bookmark_empty")
        self.navigationItem.rightBarButtonItem = bookmarkBtn
        btnButton.setCornerRadius(to: 10)
        imgPoster.layer.masksToBounds = true
        imgPoster.layer.cornerRadius = 5
        
        CVMovieCasts.register(MovieCastCell.self, forCellWithReuseIdentifier: MovieCastCell.identifier)
        CVMovieCasts.dataSource = self
        CVMovieCasts.delegate = self
        
        self.presenter?.fetchMovieDetail(movieId: movieId)
        self.presenter?.fetchMovieCredits(movieId: movieId)
    }
    
    func bindData() {
        if let detail = movieDetail {
            self.lblTitle.text = detail.original_title
            if let imgCover = detail.backdrop_path {
                self.imgCover.sd_setImage(with: URL(string: "\(API.BASE_IMG_URL)\(imgCover)"), placeholderImage: UIImage(named: "placeholder_image"), options: SDWebImageOptions.progressiveLoad, completed: nil)
            }
            if let imgPoster = detail.poster_path {
                self.imgPoster.sd_setImage(with: URL(string: "\(API.BASE_IMG_URL)\(imgPoster)"), placeholderImage: UIImage(named: "placeholder_image"), options: SDWebImageOptions.progressiveLoad, completed: nil)
            }
            let genres = detail.genres?.allObjects as! [MovieGenreVO]
            createLables(genre: genres)
            self.lblRating.text = String(detail.vote_average)
            self.lblOverview.text = detail.overview
            self.lblOriginalLang.text = " (\(detail.original_language?.uppercased() ?? "")) "
            if let rDate = detail.release_date {
                let dateComp = rDate.components(separatedBy: "-")
                let releaseDate = " \(dateComp.last!)/\(dateComp[1])/\(dateComp.first!) "
                self.lblReleaseDate.text = releaseDate
                self.lblTitle.text! += " (\(dateComp.first!))"
            }
        }
    }
    
    private func createLables(genre: [MovieGenreVO]) {
        //Stack View
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing = 3
        
        genre.forEach { genre in
            let textLabel = UILabel()
            textLabel.backgroundColor = UIColor.yellow
            textLabel.font = UIFont.systemFont(ofSize: 12)
            textLabel.text = genre.name
            textLabel.textAlignment = .center
            stackView.addArrangedSubview(textLabel)
        }
        self.genreVStuckView.addArrangedSubview(stackView)
        self.VStuckHeight.constant = 30
    }
    
    @objc func onTouchBookmarkBtn(_ sender: UIButton) {
        if bookmarkStatus {
            if let status = presenter?.removeBookmarkMovie(movieId: self.movieId) {
                bookmarkBtn.image = status ? #imageLiteral(resourceName: "bookmark_empty") : #imageLiteral(resourceName: "bookmark_filled")
            }
        }else {
            if let status = presenter?.saveBookmarkMovie(movieId: self.movieId) {
                bookmarkBtn.image = status ? #imageLiteral(resourceName: "bookmark_filled") : #imageLiteral(resourceName: "bookmark_empty")
            }
        }
    }
}

extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = movieCasts?.count ?? 0
        return count > 10 ? 10 : count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCastCell.identifier, for: indexPath) as? MovieCastCell else {
            return UICollectionViewCell()
        }
        let cast = movieCasts![indexPath.row]
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

