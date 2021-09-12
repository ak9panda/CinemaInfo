//
//  MovieModel.swift
//  CinemaInfo
//
//  Created by admin on 15/02/2021.
//

import Foundation

protocol MovieNetworkClientProtocol: ClientAPI {
    
    func fetchMovieList(Completion: @escaping(_ response: [MovieInfoResponse], _ error: String) -> Void)
    
    func fetchTopRatedMovies(pageId : Int, Completion: @escaping(Result<MovieListResponse, APIError>)-> Void)
    
    func fetchPopularMovies(pageId : Int, Completion: @escaping(Result<MovieListResponse, APIError>)-> Void)
    
    func fetchUpcomingMovies(pageId : Int, Completion: @escaping(Result<MovieListResponse, APIError>)-> Void)
    
    func fetchNowPlayingMovies(pageId : Int, Completion: @escaping(Result<MovieListResponse, APIError>)-> Void)
}

class MovieNetworkClient: MovieNetworkClientProtocol {
    
    static let shared = MovieNetworkClient()
    
    func fetchMovieList(Completion: @escaping(_ response: [MovieInfoResponse], _ error: String) -> Void) {
        var movieInfoResponse = [MovieInfoResponse]()
        var localizeError: String = ""
        fetchTopRatedMovies { [weak self] results in
            switch results {
            case .success(let movieListResponse):
                movieListResponse.results.forEach { movieInfo in
                    var data = movieInfo
                    data.movieTag = MovieTag.TOP_RATED
                    movieInfoResponse.append(data)
                }
            case .failure(let error):
                localizeError = error.localizedDescription + " toprated movie "
            }
            
            self?.fetchPopularMovies { [weak self] results in
                switch results {
                case .success(let movieListResponse):
                    movieListResponse.results.forEach { movieInfo in
                        var data = movieInfo
                        data.movieTag = MovieTag.POPULAR
                        movieInfoResponse.append(data)
                    }
                case .failure(let error):
                    localizeError += error.localizedDescription + " popular movie "
                }
                
                self?.fetchUpcomingMovies { [weak self] results in
                    switch results {
                    case .success(let movieListResponse):
                        movieListResponse.results.forEach { movieInfo in
                            var data = movieInfo
                            data.movieTag = MovieTag.UPCOMING
                            movieInfoResponse.append(data)
                        }
                    case .failure(let error):
                        localizeError += error.localizedDescription + " upcoming movie "
                    }
                    
                    self?.fetchNowPlayingMovies { results in
                        switch results {
                        case .success(let movieListResponse):
                            movieListResponse.results.forEach { movieInfo in
                                var data = movieInfo
                                data.movieTag = MovieTag.NOW_PLAYING
                                movieInfoResponse.append(data)
                            }
                        case .failure(let error):
                            localizeError += error.localizedDescription + " nowplaying movie "
                        }
                        
                        Completion(movieInfoResponse, localizeError)
                    }
                }
            }
        }
    }
    
    func fetchTopRatedMovies(pageId : Int = 1, Completion: @escaping(Result<MovieListResponse, APIError>)-> Void) {
        let route = URL(string: "\(Routes.ROUTE_TOP_RATED_MOVIES)&page=\(pageId)")!
        URLSession.shared.dataTask(with: route) { (data, urlResponse, error) in
            guard let result : (Result<MovieListResponse, APIError>) = self.responseHandler(data: data, urlResponse: urlResponse, error: error) else {
                return
            }
            Completion(result)
        }.resume()
    }
    
    func fetchPopularMovies(pageId : Int = 1, Completion: @escaping(Result<MovieListResponse, APIError>)-> Void) {
        let route = URL(string: "\(Routes.ROUTE_POPULAR_MOVIES)&page=\(pageId)")!
        URLSession.shared.dataTask(with: route) { (data, urlResponse, error) in
            guard let result : (Result<MovieListResponse, APIError>) = self.responseHandler(data: data, urlResponse: urlResponse, error: error) else {
                return
            }
            Completion(result)
        }.resume()
    }
    
    func fetchUpcomingMovies(pageId : Int = 1, Completion: @escaping(Result<MovieListResponse, APIError>)-> Void) {
        let route = URL(string: "\(Routes.ROUTE_UPCOMING_MOVIES)&page=\(pageId)")!
        URLSession.shared.dataTask(with: route) { (data, urlResponse, error) in
            guard let result : (Result<MovieListResponse, APIError>) = self.responseHandler(data: data, urlResponse: urlResponse, error: error) else {
                return
            }
            Completion(result)
        }.resume()
    }
    
    func fetchNowPlayingMovies(pageId : Int = 1, Completion: @escaping(Result<MovieListResponse, APIError>)-> Void) {
        let route = URL(string: "\(Routes.ROUTE_NOW_PLAYING_MOVIES)&page=\(pageId)")!
        URLSession.shared.dataTask(with: route) { (data, urlResponse, error) in
            guard let result : (Result<MovieListResponse, APIError>) = self.responseHandler(data: data, urlResponse: urlResponse, error: error) else {
                return
            }
            Completion(result)
        }.resume()
    }
    
    func fetchMovieCredits(movieId: Int = 0, Completion: @escaping(Result<MovieCreditsResponse, APIError>)->Void) {
        let route = URL(string: "\(Routes.ROUTE_MOVIE_DETAILS)/\(movieId)/credits?api_key=\(API.KEY)")!
        URLSession.shared.dataTask(with: route) { (data, urlResponse, error) in
            guard let result: (Result<MovieCreditsResponse, APIError>) = self.responseHandler(data: data, urlResponse: urlResponse, error: error) else {
                return
            }
            Completion(result)
        }.resume()
    }
    
    func fetchGenreList(Completion: @escaping(Result<GenreListResponse, APIError>) -> Void) {
        let route = URL(string: "\(Routes.ROUTE_MOVIE_GENRES)")!
        URLSession.shared.dataTask(with: route) { (data, urlResponse, error) in
            guard let result: (Result<GenreListResponse, APIError>) = self.responseHandler(data: data, urlResponse: urlResponse, error: error) else {
                return
            }
            Completion(result)
        }.resume()
    }
    
}
