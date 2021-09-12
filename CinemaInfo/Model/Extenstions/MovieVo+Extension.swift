//
//  MovieVo+Extension.swift
//  CinemaInfo
//
//  Created by admin on 09/08/2021.
//

import Foundation
import CoreData

extension MovieVO {
    
    static func fetchMovies() -> [MovieVO]? {
        let fetchRequest: NSFetchRequest<MovieVO> = MovieVO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "popularity", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let data = try? CoreDataStack.shared.viewContext.fetch(fetchRequest) {
            return data
        }
        
        return nil
    }
    
    static func deleteAllMovies() {
        let fetchRequest: NSFetchRequest<MovieVO> = MovieVO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "popularity", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let data = try? CoreDataStack.shared.viewContext.fetch(fetchRequest), !data.isEmpty {
            data.forEach { movie in
                CoreDataStack.shared.viewContext.delete(movie)
            }
            try? CoreDataStack.shared.viewContext.save()
        }
    }
    
    static func getMovieById(movieId: Int) -> MovieVO? {
        let fetchRequest: NSFetchRequest<MovieVO> = MovieVO.fetchRequest()
        let predicate = NSPredicate(format: "id == %d", movieId)
        fetchRequest.predicate = predicate
        
        do {
            let data = try CoreDataStack.shared.viewContext.fetch(fetchRequest)
            if data.isEmpty {
                return nil
            }
            return data[0]
        }catch {
            print("failed to fetch movie with id \(movieId): \(error.localizedDescription)")
            return nil
        }
    }
}
