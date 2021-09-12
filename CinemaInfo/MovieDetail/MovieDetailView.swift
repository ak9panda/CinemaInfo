//
//  MovieDetailView.swift
//  CinemaInfo
//
//  Created by admin on 17/08/2021.
//

import Foundation

protocol MovieDetailViewProtocol: AnyObject {
    func showError(msg: String)
    func showLoading()
    func hideLoading()
    func bindMovieData(movie: MovieVO)
    func bindMovieCastsData(casts: [Cast])
    func bindGenres(name: [String])
    func saveBookmark(movieId: Int)
}

extension MovieDetailViewController: MovieDetailViewProtocol {
    
    func showError(msg: String) {
        Dialog.showAlert(viewController: self, title: "Error", message: msg)
    }
    
    func showLoading() {
        loadingVC.showAlert(sourceView: self)
    }
    
    func hideLoading() {
        loadingVC.hideAlert()
    }
    
    func bindMovieData(movie: MovieVO) {
        self.movieDetail = movie
    }
    
    func bindMovieCastsData(casts: [Cast]) {
        self.movieCasts = casts
    }
    
    func bindGenres(name: [String]) {
        self.genres = name
    }
    
    func saveBookmark(movieId: Int) {
        guard let _ = presenter?.saveBookmarkMovie(movieId: movieId) else {
            showError(msg: "Cannot bookmark")
            return
        }
    }

}
