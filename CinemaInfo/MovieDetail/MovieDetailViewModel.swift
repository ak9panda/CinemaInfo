//
//  MovieDetailViewModel.swift
//  CinemaInfo
//
//  Created by admin on 29/09/2021.
//

import Foundation

struct MovieDetailViewModel {
    
    let movieDetail: Observable<MovieVO> = Observable(MovieVO())
    let movieCasts: Observable<[Cast]> = Observable([])
    
    func fetchMovieDetail(movieId: Int) {
        // fetch casts
        fetchMovieCasts(movieId: movieId)
        if let detail = MovieVO.getMovieById(movieId: movieId) {
            self.movieDetail.value = detail
        }
    }
    
    func fetchMovieCasts(movieId: Int) {
        MovieNetworkClient.shared.fetchMovieCredits(movieId: movieId) { result in
            switch result {
            case .success(let credits):
                self.movieCasts.value = credits.cast
            case .failure(let error):
                print("error \(error)")
            }
        }
    }
    
    func getBookmarkStatus(movieId: Int) -> Bool {
        return MovieBookmarkVO.isBookmarked(movieId: movieId)
    }
    
    func saveBookmark(movieId: Int) -> Bool {
        return MovieBookmarkVO.save(movieId: movieId, context: CoreDataStack.shared.viewContext)
    }
    
    func removeBookmark(movieId: Int) -> Bool {
        return MovieBookmarkVO.remove(movieId: movieId, context: CoreDataStack.shared.viewContext)
    }
}
