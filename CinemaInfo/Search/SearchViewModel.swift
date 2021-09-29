//
//  SearchViewModel.swift
//  CinemaInfo
//
//  Created by admin on 29/09/2021.
//

import Foundation

struct SearchViewModel {
    
    let resultMovies: Observable<[MovieInfoResponse]> = Observable([])
    
    func fetchMovies(by name: String) {
        SearchNetworkClient.shared.fetchSearchMovies(name: name) { result in
            switch result {
            case .success(let movies):
                self.resultMovies.value = movies.results
            case .failure(let error):
                print("error \(error)")
            }
        }
    }
}
