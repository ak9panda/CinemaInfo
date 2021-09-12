//
//  MovieListRouter.swift
//  CinemaInfo
//
//  Created by admin on 03/08/2021.
//

import Foundation
import UIKit

protocol MovieListRouterProtocol: AnyObject {
    func navigateToMovieDetailViewController(viewController: UIViewController, data: MovieVO?)
    func navigateToSearchMovesViewController(viewController: UIViewController)
    static func createVC() -> UINavigationController
}

class MovieListRouter: MovieListRouterProtocol {
    func navigateToMovieDetailViewController(viewController: UIViewController, data: MovieVO?) {
        if let data = data {
            if let movieDetailVC = viewController.storyboard?.instantiateViewController(withIdentifier: String(describing: MovieDetailViewController.self)) as? MovieDetailViewController {
                movieDetailVC.movieId = Int(data.id)
                viewController.navigationController?.pushViewController(movieDetailVC, animated: true)
            }
        }
    }
    
    func navigateToSearchMovesViewController(viewController: UIViewController) {
        if let VC = viewController.storyboard?.instantiateViewController(withIdentifier: String(describing: SearchViewController.self)) as? SearchViewController {
            viewController.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    static func createVC() -> UINavigationController {
        let navVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier:  String(describing: MovieListViewController.self)) as! UINavigationController
        
        let movieListVC = navVC.viewControllers[0] as! MovieListViewController
        
        let presenter = MovieListPresenter()
        let interactor = MovieListInteractor()
        let router = MovieListRouter()
        let networkAPI = MovieNetworkClient()
        let dataManger = MovieListDataManger()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = movieListVC
        
        interactor.presenter = presenter
        interactor.networkAPI = networkAPI
        interactor.dataManger = dataManger
        
        movieListVC.presenter = presenter
        
        return navVC
    }
    
    
}
