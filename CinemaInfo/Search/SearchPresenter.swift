//
//  SearchPresenter.swift
//  CinemaInfo
//
//  Created by admin on 31/08/2021.
//

import Foundation

protocol SearchPresenterProtocol {
    var interactor: SearchInteractorProtocol? { get set }
    var router: SearchRouterProtocol? { get set }
    var view: SearchViewProtocol? { get set }
    func fetchSearchMovies(by name: String)
}

class SearchPresenter: SearchPresenterProtocol {
    var view: SearchViewProtocol?
    var router: SearchRouterProtocol?
    var interactor: SearchInteractorProtocol?
    
    func fetchSearchMovies(by name: String) {
        interactor?.retrieveSearchMovies(name: name)
    }
}
