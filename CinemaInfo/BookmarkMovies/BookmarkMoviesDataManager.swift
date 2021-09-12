//
//  BookmarkMoviesDataManager.swift
//  CinemaInfo
//
//  Created by admin on 17/08/2021.
//

import Foundation
import CoreData

protocol BookmarkMoviesDataManagerProtocol {
    func retrieveBookmarkMovies() -> [MovieVO?]
}

class BookmarkMoviesDataManager: BookmarkMoviesDataManagerProtocol {
    func retrieveBookmarkMovies() -> [MovieVO?] {
        return MovieBookmarkVO.fetch()
    }
}
