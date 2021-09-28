//
//  BookmarkMoviesViewController.swift
//  CinemaInfo
//
//  Created by admin on 17/08/2021.
//

import UIKit
import SDWebImage

class BookmarkMoviesViewController: UIViewController {
    
    @IBOutlet weak var bookmarkMoviesCollectionView: UICollectionView!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:#selector(handleRefresh(_:)),for: .valueChanged)
        refreshControl.tintColor = .green
        return refreshControl
    }()
    
    private var bookmarksVM = BookmarkViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        bookmarksVM.bookmarkList.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.bookmarkMoviesCollectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bookmarksVM.fetchBookmarkMovies()
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
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.refreshControl.endRefreshing()
        bookmarksVM.fetchBookmarkMovies()
    }
}

extension BookmarkMoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookmarksVM.bookmarkList.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: CoverCell.identifier, for: indexPath) as? CoverCell else {
            return UICollectionViewCell()
        }
        let bookmarks = bookmarksVM.bookmarkList.value
        if let movie = bookmarks?[indexPath.row] {
            cell.poster = movie.poster_path
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bookmarks = bookmarksVM.bookmarkList.value
        if let movie = bookmarks?[indexPath.row] {
            if let movieDetailVC = self.storyboard?.instantiateViewController(withIdentifier: String(describing: MovieDetailViewController.self)) as? MovieDetailViewController {
                movieDetailVC.movieId = Int(movie.id)
                self.navigationController?.pushViewController(movieDetailVC, animated: true)
            }
        }
    }
}

extension BookmarkMoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width / 3) - 15;
        return CGSize(width: width, height: width * 1.45)
    }
}
