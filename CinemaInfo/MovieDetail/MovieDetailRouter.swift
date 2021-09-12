//
//  MovieDetailRouter.swift
//  CinemaInfo
//
//  Created by admin on 17/08/2021.
//

import Foundation

protocol MovieDetailRouterProtocol {
    static func createVC()
}

class MovieDetailRouter: MovieDetailRouterProtocol {
    
    static func createVC() {
        let presenterr = MovieDetailPresenter()
        let router = MovieDetailRouter()
        
        presenterr.router = router
    }
}
