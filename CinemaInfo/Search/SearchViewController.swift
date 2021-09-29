//
//  SearchViewController.swift
//  CinemaInfo
//
//  Created by admin on 28/08/2021.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchResultsTableView: UITableView!
    
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    private var searchMovieVM = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        searchMovieVM.resultMovies.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.searchResultsTableView.reloadData()
            }
        }
    }
    
    private func setupView() {
        searchBar.placeholder = "Search movies"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()
        
        searchResultsTableView.dataSource = self
        searchResultsTableView.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            searchMovieVM.fetchMovies(by: text)
        }
        searchBar.resignFirstResponder()
    }
    
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

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let results = searchMovieVM.resultMovies.value?.count ?? 0
        if results > 0 {
            self.restore()
        }else {
            self.showEmptyMessage()
        }
        return results
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchedMovieCell.identifier, for: indexPath) as? SearchedMovieCell else {
            return UITableViewCell()
        }
        cell.movie = searchMovieVM.resultMovies.value![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
