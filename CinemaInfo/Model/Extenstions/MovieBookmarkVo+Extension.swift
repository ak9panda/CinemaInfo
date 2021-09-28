//
//  MovieBookmarkVo+Extension.swift
//  CinemaInfo
//
//  Created by admin on 18/08/2021.
//

import Foundation
import CoreData

extension MovieBookmarkVO {
    
    static func save(movieId: Int, context: NSManagedObjectContext) -> Bool {
        let entity = MovieBookmarkVO(context: context)
        entity.id = Int32(movieId)
        do {
            try context.save()
            return true
        }catch {
            print("failed to save bookmark movie")
            return false
        }
    }
    
    static func remove(movieId: Int, context: NSManagedObjectContext) -> Bool {
        let fetchRequset: NSFetchRequest<MovieBookmarkVO> = MovieBookmarkVO.fetchRequest()
        fetchRequset.predicate = NSPredicate(format: "id == %d", movieId)
        do {
            let data = try context.fetch(fetchRequset)
            if !data.isEmpty {
                data.forEach { movie in
                    context.delete(movie)
                }
                try? context.save()
                return true
            }
            return false
        }catch {
            print("failed to remove bookmark movie")
            return false
        }
    }
    
    static func fetch() -> [MovieVO]? {
        let fetchRequest: NSFetchRequest<MovieBookmarkVO> = MovieBookmarkVO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let data = try CoreDataStack.shared.viewContext.fetch(fetchRequest)
            if data.isEmpty {
                return [MovieVO]()
            }
            var bookmarkMovies = [MovieVO]()
            data.forEach { movie in
                let movieId = movie.id
                bookmarkMovies.append(MovieVO.getMovieById(movieId: Int(movieId))!)
            }
            return bookmarkMovies
        }catch {
            print("GetBookmarkMovies : \(error.localizedDescription)")
            return [MovieVO]()
        }
    }
    
    static func isBookmarked(movieId: Int) -> Bool {
        let fetchRequest: NSFetchRequest<MovieBookmarkVO> = MovieBookmarkVO.fetchRequest()
        let predicate = NSPredicate(format: "id == %d", Int32(movieId))
        fetchRequest.predicate = predicate
        do {
            let data = try CoreDataStack.shared.viewContext.fetch(fetchRequest)
            return data.count > 0
        }catch {
            print("isBookmarked: \(error.localizedDescription)")
            return false
        }
    }
}
