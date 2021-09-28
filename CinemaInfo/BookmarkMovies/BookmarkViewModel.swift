//
//  BookmarkViewModel.swift
//  CinemaInfo
//
//  Created by admin on 28/09/2021.
//

import Foundation

struct BookmarkViewModel {
    
    let bookmarkList: Observable<[MovieVO]> = Observable([])
    
    func fetchBookmarkMovies() {
        if let bookmarks = MovieBookmarkVO.fetch() {
            self.bookmarkList.value = bookmarks
        }
    }
}
