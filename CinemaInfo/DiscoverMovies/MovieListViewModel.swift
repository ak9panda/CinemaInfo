//
//  MovieListViewModel.swift
//  CinemaInfo
//
//  Created by admin on 28/09/2021.
//

import Foundation

struct MovieListViewModel {
    
    let movieList: Observable<[MovieVO]> = Observable([])
    
    func fetchGenres() {
        if let _ = MovieGenreVO.getGenreList() {
            
        }else {
            MovieNetworkClient.shared.fetchGenreList { result in
                switch result {
                case .success(let genres):
                    Genre.saveGenre(data: genres.genres, context: CoreDataStack.shared.viewContext)
                case .failure(let error):
                    print("error \(error)")
                }
            }
        }
    }
    
    func fetchMovies() {
        
        //fetch genres first
        fetchGenres()
        
        if let movies = MovieVO.fetchMovies() {
            if movies.isEmpty {
                MovieNetworkClient.shared.fetchMovieList { response, error in
                    DispatchQueue.main.async {
                        if error.count > 0 {
                            print("error")
                        }else {
                            response.forEach { movie in
                                MovieInfoResponse.saveMovieEntity(data: movie, context: CoreDataStack.shared.viewContext)
                            }
                            self.movieList.value = MovieVO.fetchMovies()
                        }
                    }
                }
            }else {
                self.movieList.value = movies
            }
        }else {
            print("error")
        }
    }
    
    func refreshMovies() {
        // delete all movies
        MovieVO.deleteAllMovies()
        // fetch movies again
        fetchMovies()
    }
}
