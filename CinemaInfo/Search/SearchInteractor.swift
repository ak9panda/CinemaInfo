//
//  SearchInteractor.swift
//  CinemaInfo
//
//  Created by admin on 31/08/2021.
//

import Foundation

protocol SearchInteractorProtocol {
    func retrieveSearchMovies(name: String)
}

class SearchInteractor: SearchInteractorProtocol {
    
    var presenter: SearchPresenterProtocol?
    
    func retrieveSearchMovies(name: String) {
        
        SearchNetworkClient.shared.fetchSearchMovies(name: name) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let searchMovies):
                    let movies = searchMovies.results
                    self?.presenter?.view?.bindData(movies: movies)
                case .failure(let error):
                    self?.presenter?.view?.showError(msg: error.localizedDescription)
                }
            }
        }
    }
}
