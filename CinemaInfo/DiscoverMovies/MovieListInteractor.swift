//
//  MovieListInteractor.swift
//  CinemaInfo
//
//  Created by admin on 03/08/2021.
//

import Foundation

protocol MovieListInteractorProtocol: AnyObject {
    func retrieveGenres()
    func retrieveMovies()
}

class MovieListInteractor: MovieListInteractorProtocol {
    
    var presenter: MovieListPresenterProtocol?
    var networkAPI: MovieNetworkClientProtocol?
    var dataManger: MovieListDataManagerProtocol?
    
    func retrieveGenres() {
        if let _ = dataManger?.retrieveGenres() {
//            print("genres are: ", genres)
        }else {
            MovieNetworkClient.shared.fetchGenreList { [weak self] results in
                switch results {
                case .success(let genres):
                    self?.dataManger?.saveGenres(data: genres.genres)
                case .failure(let error):
                    self?.presenter?.view?.showError(msg: error.localizedDescription)
                }
            }
        }
    }
    
    func retrieveMovies() {
        self.presenter?.view?.showLoading()
        
        if let movieList = dataManger?.retrieveMovies() {
            if movieList.isEmpty {
                MovieNetworkClient.shared.fetchMovieList { [weak self] response, error in
                    DispatchQueue.main.async {
                        self?.presenter?.view?.hideLoading()
                        if error.count > 0 {
                            self?.presenter?.view?.showError(msg: error)
                        }
                        self?.dataManger?.saveMovies(data: response)
                        if let movieList = MovieVO.fetchMovies() {
                            self?.presenter?.view?.bindMovie(data: movieList)
                        }
                    }
                }
            } else {
                self.presenter?.view?.hideLoading()
                self.presenter?.view?.bindMovie(data: movieList)
            }
        }else {
            self.presenter?.view?.hideLoading()
            self.presenter?.view?.showError(msg: "Failed to get data.")
        }
        
        
    }
}
