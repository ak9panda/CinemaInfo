//
//  MovieListViewController.swift
//  CinemaInfo
//
//  Created by admin on 03/08/2021.
//

import UIKit
import CoreData
import SDWebImage

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    var presenter: MovieListPresenterProtocol?
    var movieTags : [MovieTag] = [.UPCOMING, .NOW_PLAYING, .TOP_RATED, .POPULAR]
    let loadingVC = LoadingIndicatorViewController(nibName: "LoadingIndicatorViewController", bundle: nil)
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:#selector(handleRefresh(_:)),for: .valueChanged)
        refreshControl.tintColor = .green
        return refreshControl
    }()

    var movieList: [MovieVO]? = [] {
        didSet {
            if let _ = movieList {
                moviesCollectionView.reloadData()
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIBarButtonItem(image: #imageLiteral(resourceName: "tmdb_logo"), style: .plain, target: self, action: nil)
        logo.tintColor = UIColor.init(named: Colors.primary.rawValue)
        self.navigationItem.leftBarButtonItem = logo
        searchBar.placeholder = "Search movies"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor.init(named: Colors.primary.rawValue)
        navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "left_arrow")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "left_arrow")
        
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        let movieCoverCellNib = UINib(nibName: "MovieCoverCell", bundle: nil)
        moviesCollectionView.register(CoverCell.self, forCellWithReuseIdentifier: CoverCell.identifier)
        moviesCollectionView.register(movieCoverCellNib, forCellWithReuseIdentifier: MovieCoverCell.identifier)
        self.moviesCollectionView.refreshControl = refreshControl
        
        self.presenter?.fetchGenres()
        self.presenter?.fetchMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.presenter?.refreshMovies()
        self.refreshControl.endRefreshing()
    }

}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return movieTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            let tag = movieTags[section].rawValue
            let filterMovieByTag = movieList?.filter{$0.movie_tag == tag}
            return filterMovieByTag?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tag = movieTags[indexPath.section].rawValue
        let filteredMovies = movieList?.filter{$0.movie_tag == tag}
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCoverCell.identifier, for: indexPath) as? MovieCoverCell else {
                return UICollectionViewCell()
            }
            cell.parientVC = self
            cell.presenter = self.presenter
            cell.movieList = filteredMovies
            return cell
        }else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoverCell.identifier, for: indexPath) as? CoverCell else {
                return UICollectionViewCell()
            }
            
            if filteredMovies?.count ?? 0 > 0 {
                if let movie = filteredMovies?[indexPath.row] {
                    cell.poster = movie.poster_path
                }
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MovieHeaderCollectionReusableView.identifier, for: indexPath) as? MovieHeaderCollectionReusableView {
            sectionHeader.lblHeader.text = movieTags[indexPath.section].rawValue
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            let tag = movieTags[indexPath.section].rawValue
            let filterMovieByTag = movieList?.filter{$0.movie_tag == tag}
            let movie = filterMovieByTag![indexPath.row]
            self.presenter?.showMovieDetail(viewController: self, data: movie)
        }
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width / 3) - 15;
        if indexPath.section == 0 {
            return CGSize(width: collectionView.bounds.width, height: width * 1.45)
        }else {
            return CGSize(width: width, height: width * 1.45)
        }
    }
}


