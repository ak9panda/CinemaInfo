//
//  SearchViewController.swift
//  CinemaInfo
//
//  Created by admin on 28/08/2021.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchResultsTableView: UITableView!
    
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    var presenter: SearchPresenterProtocol?
    
    var searchResults: [MovieInfoResponse]? {
        didSet {
            if let _ = searchResults {
                DispatchQueue.main.async {
                    self.searchResultsTableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        setupView()
    }
    
    private func initView() {
        let presenter = SearchPresenter()
        let interactor = SearchInteractor()
        let router = SearchRouter()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = self
        
        interactor.presenter = presenter
        
        self.presenter = presenter
    }
    
    private func setupView() {
        searchBar.placeholder = "Search movies"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()
        
        searchResultsTableView.dataSource = self
        searchResultsTableView.delegate = self
    }
    
    func performSearch(name: String) {
        presenter?.fetchSearchMovies(by: name)
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let results = searchResults?.count ?? 0
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
        cell.movie = searchResults![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
