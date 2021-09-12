//
//  MovieListView.swift
//  CinemaInfo
//
//  Created by admin on 05/08/2021.
//

import Foundation
import UIKit

protocol MovieListViewProtocol: AnyObject {
    func showError(msg: String)
    func showLoading()
    func hideLoading()
    func bindMovie(data: [MovieVO])
}

extension MovieListViewController: MovieListViewProtocol, UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        presenter?.router?.navigateToSearchMovesViewController(viewController: self)
    }
    
    func showError(msg: String) {
        Dialog.showAlert(viewController: self, title: "Error", message: msg)
    }
    
    func showLoading() {
        loadingVC.showAlert(sourceView: self)
    }
    
    func hideLoading() {
        loadingVC.hideAlert()
    }
    
    func bindMovie(data: [MovieVO]) {
        self.movieList = data
    }
    
}
