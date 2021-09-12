//
//  MovieDetailInteractor.swift
//  CinemaInfo
//
//  Created by admin on 17/08/2021.
//

import Foundation
import CoreData

protocol MovieDetailInteractorProtocol {
    func retrieveMovieDetail(movieId: Int)
    func saveBookmarkMovie(movieId: Int) -> Bool
    func removeBookmarkMovie(movieId: Int) -> Bool
    func getBookmarkStatus(movidId: Int) -> Bool
    func retrieveMovieCredits(movieId: Int)
}

class MovieDetailInteractor: MovieDetailInteractorProtocol {
    
    var preseanter: MovieDetailPresenterProtocol?
    var dataManager: MovieDetailDataManagerProtocol?
    
    func retrieveMovieDetail(movieId: Int) {
        self.preseanter?.view?.showLoading()
        
        if let movieDetail = dataManager?.retrieveMovieDetail(movieId: movieId) {
            self.preseanter?.view?.hideLoading()
            self.preseanter?.view?.bindMovieData(movie: movieDetail)
        }
    }
    
    func retrieveMovieCredits(movieId: Int) {
        MovieNetworkClient.shared.fetchMovieCredits(movieId: movieId) { [weak self] result in   
            DispatchQueue.main.async {
                switch result {
                case .success(let movieCreditResponse):
                    self?.preseanter?.view?.bindMovieCastsData(casts: movieCreditResponse.cast)
                case .failure(let error):
                    self?.preseanter?.view?.showError(msg: error.localizedDescription)
                }
            }
        }
    }
    
    func saveBookmarkMovie(movieId: Int) -> Bool {
        return ((dataManager?.saveBookmark(movieId: movieId)) != nil)
    }
    
    func removeBookmarkMovie(movieId: Int) -> Bool {
        return ((dataManager?.deleteBookmark(movieId: movieId)) != nil)
    }
    
    func getBookmarkStatus(movidId: Int) -> Bool {
        return MovieBookmarkVO.isBookmarked(movieId: movidId)
    }
}
