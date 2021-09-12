//
//  BookmarkMoviesPresenter.swift
//  CinemaInfo
//
//  Created by admin on 17/08/2021.
//

import Foundation
import UIKit

protocol BookmarkMoviesPresenterProtocol {
    var view: BookmarkMoviesViewProtocol? { get set }
    var interactor: BookmarkMoviesInteractorProtocol? { get set }
    var router: BookmarkMoviesRouterProtocol? { get set }
    
    func fetchMovies()
    func showMovieDetail(VC: UIViewController, movieId: Int)
}

class BookmarkMoviesPresenter: BookmarkMoviesPresenterProtocol {
    var interactor: BookmarkMoviesInteractorProtocol?
    var router: BookmarkMoviesRouterProtocol?
    var view: BookmarkMoviesViewProtocol?
    
    func fetchMovies() {
        if let movies = interactor?.retrieveBookmarks() {
            view?.bindData(movies: movies)
        }else {
            view?.showError(msg: "Error in getting movies")
        }
    }
    
    func showMovieDetail(VC: UIViewController, movieId: Int) {
        router?.navigateToMovieDetailViewController(viewController: VC, movieId: movieId)
    }
    
}
