//
//  SearchView.swift
//  CinemaInfo
//
//  Created by admin on 31/08/2021.
//

import Foundation
import UIKit

protocol SearchViewProtocol {
    func bindData(movies: [MovieInfoResponse])
    func showError(msg: String)
}

extension SearchViewController: SearchViewProtocol, UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            self.performSearch(name: text)
        }
        searchBar.resignFirstResponder()
    }
    
    func bindData(movies: [MovieInfoResponse]) {
        self.searchResults = movies
    }
    
    func showError(msg: String) {
        Dialog.showAlert(viewController: self, title: "Error", message: msg)
    }
    
    func showEmptyMessage() {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.searchResultsTableView.bounds.size.width, height: self.searchResultsTableView.bounds.size.height))
        messageLabel.text = "There is no match movies found!"
        messageLabel.textColor = .darkGray
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 15)
        messageLabel.sizeToFit()

        self.searchResultsTableView.backgroundView = messageLabel
        self.searchResultsTableView.separatorStyle = .none
    }
    
    func restore() {
        self.searchResultsTableView.backgroundView = nil
        self.searchResultsTableView.separatorStyle = .singleLine
    }
}
