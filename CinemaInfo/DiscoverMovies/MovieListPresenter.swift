//
//  MovieListPresenter.swift
//  CinemaInfo
//
//  Created by admin on 03/08/2021.
//

import Foundation
import UIKit

protocol MovieListPresenterProtocol: AnyObject {
    var view: MovieListViewProtocol? { get set }
    var interactor: MovieListInteractorProtocol? { get set }
    var router: MovieListRouterProtocol? { get set }
    func fetchGenres()
    func fetchMovies()
    func refreshMovies()
    func showMovieDetail(viewController : UIViewController, data: MovieVO)
}

class MovieListPresenter: MovieListPresenterProtocol {
    
    weak var view: MovieListViewProtocol?
    var interactor: MovieListInteractorProtocol?
    var router: MovieListRouterProtocol?
    
    func fetchGenres() {
        interactor?.retrieveGenres()
    }
    
    func fetchMovies() {
        interactor?.retrieveMovies()
    }
    
    func refreshMovies() {
        MovieVO.deleteAllMovies()
        interactor?.retrieveGenres()
        interactor?.retrieveMovies()
    }
    
    func showMovieDetail(viewController: UIViewController, data: MovieVO) {
        router?.navigateToMovieDetailViewController(viewController: viewController, data: data)
    }
}
