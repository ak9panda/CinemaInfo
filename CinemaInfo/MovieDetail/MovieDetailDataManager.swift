//
//  MovieDetailDataManager.swift
//  CinemaInfo
//
//  Created by admin on 18/08/2021.
//

import Foundation
import CoreData

protocol MovieDetailDataManagerProtocol {
    func retrieveMovieDetail(movieId: Int) -> MovieVO?
    func saveBookmark(movieId: Int) -> Bool
    func deleteBookmark(movieId: Int) -> Bool
}

class MovieDetailDataManager: MovieDetailDataManagerProtocol {
    
    private let dbContext = CoreDataStack.shared.viewContext
    
    func retrieveMovieDetail(movieId: Int) -> MovieVO? {
        return MovieVO.getMovieById(movieId: movieId)
    }
    
    func saveBookmark(movieId: Int) -> Bool {
        return MovieBookmarkVO.save(movieId: movieId, context: dbContext) 
    }
    
    func deleteBookmark(movieId: Int) -> Bool {
        return MovieBookmarkVO.remove(movieId: movieId, context: dbContext)
    }
}


