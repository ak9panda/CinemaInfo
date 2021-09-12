//
//  BookmarkMoviesRouter.swift
//  CinemaInfo
//
//  Created by admin on 17/08/2021.
//

import Foundation
import UIKit

protocol BookmarkMoviesRouterProtocol {
    func navigateToMovieDetailViewController(viewController: UIViewController, movieId: Int)
    static func createVC() -> UINavigationController
}

class BookmarkMoviesRouter: BookmarkMoviesRouterProtocol {
    
    func navigateToMovieDetailViewController(viewController: UIViewController, movieId: Int) {
        if let movieDetailVC = viewController.storyboard?.instantiateViewController(withIdentifier: String(describing: MovieDetailViewController.self)) as? MovieDetailViewController {
            movieDetailVC.movieId = movieId
            viewController.navigationController?.pushViewController(movieDetailVC, animated: true)
        }
    }
    
    static func createVC() -> UINavigationController {
        
        let navVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier:  String(describing: BookmarkMoviesViewController.self)) as! UINavigationController
        
        let bookmarkMoviesVC = navVC.viewControllers[0] as! BookmarkMoviesViewController
        
        let presenter = BookmarkMoviesPresenter()
        let interactor = BookmarkMoviesInteractor()
        let router = BookmarkMoviesRouter()
        let dataManager = BookmarkMoviesDataManager()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = bookmarkMoviesVC
        
        interactor.presenter = presenter
        interactor.dataManger = dataManager
        
        bookmarkMoviesVC.presenter = presenter
        
        return navVC
    }
}
