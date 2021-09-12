//
//  SearchNetworkClient.swift
//  CinemaInfo
//
//  Created by admin on 31/08/2021.
//

import Foundation

class SearchNetworkClient: ClientAPI {
    
    static let shared = SearchNetworkClient()
    
    // Search movies by name
    func fetchSearchMovies(name: String = "", Completion: @escaping(Result<MovieListResponse, APIError>) -> Void) {
        let string = "\(Routes.ROUTE_SEACRH_MOVIES)&query=\(name)"
        let urlString = string.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let route = URL(string: urlString)!
        URLSession.shared.dataTask(with: route) { (data, urlResponse, error) in
            guard let result: (Result<MovieListResponse, APIError>) = self.responseHandler(data: data, urlResponse: urlResponse, error: error) else {
                return
            }
            Completion(result)
        }.resume()
    }
}
