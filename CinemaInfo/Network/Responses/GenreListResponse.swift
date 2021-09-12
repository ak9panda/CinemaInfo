//
//  GenreListResponse.swift
//  CinemaInfo
//
//  Created by admin on 01/09/2021.
//

import Foundation
import CoreData

// MARK: - GenreListResponse
struct GenreListResponse: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
    
    static func saveGenre(data: [Genre], context: NSManagedObjectContext) {
        
        data.forEach { (genre) in
            let entity = MovieGenreVO(context: context)
            entity.id = Int32(genre.id)
            entity.name = genre.name
            
            do {
                try context.save()
            }catch {
                print("failed to save movie genre : \(error.localizedDescription)")
            }
        }
        
    }
}
