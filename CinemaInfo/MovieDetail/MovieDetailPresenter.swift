//
//  MovieDetailPresenter.swift
//  CinemaInfo
//
//  Created by admin on 09/08/2021.
//

import Foundation

protocol MovieDetailPresenterProtocol: AnyObject {
    var view : MovieDetailViewProtocol? { get set }
    var interactor : MovieDetailInteractorProtocol? { get set }
    var router : MovieDetailRouterProtocol? { get set }
    
    func fetchMovieDetail(movieId: Int)
    func fetchMovieCredits(movieId: Int)
    func saveBookmarkMovie(movieId: Int) -> Bool
    func removeBookmarkMovie(movieId: Int) -> Bool
    func getBookmarkStatus(movieId: Int) -> Bool
}

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    weak var view: MovieDetailViewProtocol?
    var router: MovieDetailRouterProtocol?
    var interactor: MovieDetailInteractorProtocol?
    
    func fetchMovieDetail(movieId: Int) {
        interactor?.retrieveMovieDetail(movieId: movieId)
    }
    
    func fetchMovieCredits(movieId: Int) {
        interactor?.retrieveMovieCredits(movieId: movieId)
    }
    
    func saveBookmarkMovie(movieId: Int) -> Bool {
        return interactor?.saveBookmarkMovie(movieId: movieId) ?? false
    }
    
    func removeBookmarkMovie(movieId: Int) -> Bool {
        return interactor?.removeBookmarkMovie(movieId: movieId) ?? false
    }
    
    func getBookmarkStatus(movieId: Int) -> Bool {
        return interactor?.getBookmarkStatus(movidId: movieId) ?? false
    }
    
}
