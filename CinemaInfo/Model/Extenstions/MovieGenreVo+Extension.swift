//
//  MovieGenreVo+Extension.swift
//  CinemaInfo
//
//  Created by admin on 09/08/2021.
//

import Foundation
import CoreData

extension MovieGenreVO {
    
    static func getGenreList() -> [MovieGenreVO]? {
        let fetchRequest : NSFetchRequest<MovieGenreVO> = MovieGenreVO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let data = try CoreDataStack.shared.viewContext.fetch(fetchRequest)
            if data.isEmpty {
                return nil
            }else {
                return data
            }
        }catch {
            print("failed to fetch movie genre vo \(error.localizedDescription)")
            return nil
        }
    }
    
    static func getMovieGenreVOById(genreId: Int) -> MovieGenreVO?{
        let fetchRequest: NSFetchRequest<MovieGenreVO> = MovieGenreVO.fetchRequest()
        let predicate = NSPredicate(format: "id == %d", genreId)
        fetchRequest.predicate = predicate
        
        do {
            let data = try CoreDataStack.shared.viewContext.fetch(fetchRequest)
            if data.isEmpty{
                return nil
            }else {
                return data[0]
            }
        }catch {
            print("failed to fetch movie genre vo \(error.localizedDescription)")
            return nil
        }
    }
}
