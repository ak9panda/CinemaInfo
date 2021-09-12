//
//  BookmarkMoviesInteractor.swift
//  CinemaInfo
//
//  Created by admin on 17/08/2021.
//

import Foundation

protocol BookmarkMoviesInteractorProtocol {
    func retrieveBookmarks() -> [MovieVO?]
}

class BookmarkMoviesInteractor: BookmarkMoviesInteractorProtocol {
    
    var presenter: BookmarkMoviesPresenterProtocol?
    var dataManger: BookmarkMoviesDataManagerProtocol?
    
    func retrieveBookmarks() -> [MovieVO?] {
        if let bookmarkMovies = dataManger?.retrieveBookmarkMovies() {
            if bookmarkMovies.isEmpty {
                return [MovieVO?]()
            }else {
                return bookmarkMovies
            }
        }
        return [MovieVO?]()
    }
}
