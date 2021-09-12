//
//  BookmarkMoviesView.swift
//  CinemaInfo
//
//  Created by admin on 17/08/2021.
//

import Foundation

protocol BookmarkMoviesViewProtocol {
    func showError(msg: String)
    func showLoading()
    func hideLoading()
    func bindData(movies: [MovieVO?])
}

extension BookmarkMoviesViewController: BookmarkMoviesViewProtocol {
    func showError(msg: String) {
        Dialog.showAlert(viewController: self, title: "Error", message: msg)
    }
    
    func showLoading() {
        loadingVC.showAlert(sourceView: self)
    }
    
    func hideLoading() {
        loadingVC.hideAlert()
    }
    
    func bindData(movies: [MovieVO?]) {
        self.bookmarkMovies = movies
    }
}
