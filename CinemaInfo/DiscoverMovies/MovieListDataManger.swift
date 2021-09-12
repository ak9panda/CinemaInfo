//
//  MovieListDataManger.swift
//  CinemaInfo
//
//  Created by admin on 09/08/2021.
//

import Foundation
import CoreData

protocol MovieListDataManagerProtocol {
    func retrieveMovies() -> [MovieVO]?
    func retrieveGenres() -> [MovieGenreVO]?
    func saveMovies(data: [MovieInfoResponse])
    func saveGenres(data: [Genre])
}

class MovieListDataManger: MovieListDataManagerProtocol {
    
    private let dbContext = CoreDataStack.shared.viewContext
    
    func retrieveGenres() -> [MovieGenreVO]? {
        return MovieGenreVO.getGenreList()
    }
    
    func retrieveMovies() -> [MovieVO]? {
        return MovieVO.fetchMovies()
    }
    
    func saveMovies(data: [MovieInfoResponse]) {
        data.forEach { movie in
            MovieInfoResponse.saveMovieEntity(data: movie, context: dbContext)
        }
    }
    
    func saveGenres(data: [Genre]) {
        Genre.saveGenre(data: data, context: dbContext)
    }
}
