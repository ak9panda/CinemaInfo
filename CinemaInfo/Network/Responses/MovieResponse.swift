//
//  MovieResponse.swift
//  CinemaInfo
//
//  Created by admin on 15/02/2021.
//

import Foundation
import CoreData

// MARK: - MovieListResponse
struct MovieListResponse : Codable {
    let page : Int
    let total_results : Int
    let total_pages : Int
    let results : [MovieInfoResponse]
}

// MARK: - Result
struct MovieInfoResponse : Codable {
    
    let popularity : Double?
    let vote_count : Int?
    let video : Bool?
    let poster_path : String?
    let id : Int?
    let adult : Bool?
    let backdrop_path : String?
    let original_language : String?
    let original_title : String?
    let genre_ids: [Int]?
    let title : String?
    let vote_average : Double?
    let overview : String?
    let release_date : String?
    let budget : Int?
    let homepage : String?
    let imdb_id : String?
    let revenue : Int?
    let runtime : Int?
    let tagline : String?
    var movieTag : MovieTag? = MovieTag.NOT_LISTED
    
    enum CodingKeys:String,CodingKey {
        case popularity
        case vote_count
        case video
        case poster_path
        case id
        case adult
        case backdrop_path
        case original_language
        case original_title
        case genre_ids
        case title
        case vote_average
        case overview
        case release_date
        case budget
        case homepage
        case imdb_id
        case revenue
        case runtime
        case tagline = "tagline"
    }
    
    static func saveMovieEntity(data: MovieInfoResponse, context: NSManagedObjectContext) {
        guard let id = data.id, id > 0 else {
            print("failed to save movie response")
            return
        }
        
        let movieEntity = MovieVO(context: context)
        movieEntity.adult = data.adult ?? false
        movieEntity.backdrop_path = data.backdrop_path ?? ""
        movieEntity.budget = Int32(data.budget ?? 0)
        
        if let genre_ids = data.genre_ids, !genre_ids.isEmpty {
            genre_ids.forEach { genre_id in
                if let movieGenreVO = MovieGenreVO.getMovieGenreVOById(genreId: genre_id) {
                    movieEntity.addToGenres(movieGenreVO)
                }
            }
        }
        
        movieEntity.homepage = data.homepage ?? ""
        movieEntity.id = Int32(data.id ?? 0)
        movieEntity.imdb_id = data.imdb_id ?? ""
        movieEntity.movie_tag = data.movieTag?.rawValue ?? ""
        movieEntity.original_language = data.original_language ?? ""
        movieEntity.original_title = data.original_title ?? ""
        movieEntity.overview = data.overview ?? ""
        movieEntity.popularity = data.popularity ?? 0.0
        movieEntity.poster_path = data.poster_path ?? ""
        movieEntity.release_date = data.release_date ?? ""
        movieEntity.revenue = Int32(data.revenue ?? 0)
        movieEntity.vote_count = Int32(data.vote_count ?? 0)
        movieEntity.vote_average = data.vote_average ?? 0
        
        context.performAndWait {
            do{
                print("movie is saved")
                try context.save()
            }catch {
                print("failed to save movies : \(error.localizedDescription)")
            }
        }
    }
    
}

enum MovieTag : String {
    case NOW_PLAYING = "Now Playing"
    case POPULAR = "Popular"
    case TOP_RATED = "Top Rated"
    case UPCOMING = "Upcoming"
    case NOT_LISTED = "Not Listed"
}
