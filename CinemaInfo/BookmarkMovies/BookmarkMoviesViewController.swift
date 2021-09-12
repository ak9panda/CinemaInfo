//
//  BookmarkMoviesViewController.swift
//  CinemaInfo
//
//  Created by admin on 17/08/2021.
//

import UIKit
import SDWebImage

class BookmarkMoviesViewController: UIViewController {
    
    var presenter: BookmarkMoviesPresenterProtocol?
    
    @IBOutlet weak var bookmarkMoviesCollectionView: UICollectionView!
    
    let loadingVC = LoadingIndicatorViewController(nibName: "LoadingIndicatorViewController", bundle: nil)
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:#selector(handleRefresh(_:)),for: .valueChanged)
        refreshControl.tintColor = .green
        return refreshControl
    }()
    
    var bookmarkMovies: [MovieVO?] = [] {
        didSet {
            bookmarkMoviesCollectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        self.navigationItem.title = "Bookmarks"
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "left_arrow")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "left_arrow")
        
        bookmarkMoviesCollectionView.dataSource = self
        bookmarkMoviesCollectionView.delegate = self
        bookmarkMoviesCollectionView.register(CoverCell.self, forCellWithReuseIdentifier: CoverCell.identifier)
        bookmarkMoviesCollectionView.refreshControl = refreshControl
        presenter?.fetchMovies()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.presenter?.fetchMovies()
        self.refreshControl.endRefreshing()
    }
}

extension BookmarkMoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookmarkMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: CoverCell.identifier, for: indexPath) as? CoverCell else {
            return UICollectionViewCell()
        }
        if let movie = bookmarkMovies[indexPath.row] {
            cell.poster = movie.poster_path
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = bookmarkMovies[indexPath.row] {
            self.presenter?.showMovieDetail(VC: self, movieId: Int(movie.id))
        }
    }
}

extension BookmarkMoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width / 3) - 15;
        return CGSize(width: width, height: width * 1.45)
    }
}
