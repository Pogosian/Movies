//
//  Movies.swift
//  TestOnseo
//
//  Created by Oleg Pogosian on 04.07.2020.
//  Copyright © 2020 Oleg Pogosian All rights reserved.
//

import Foundation

// MARK: - MoviesResponse
struct MoviesResponse: Codable {
    var page, totalResults, totalPages: Int
    var movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        page = (try? values.decodeIfPresent(Int.self, forKey: .page))                          ?? 0
        totalResults = (try? values.decodeIfPresent(Int.self, forKey: .totalResults))          ?? 0
        totalPages = (try? values.decodeIfPresent(Int.self, forKey: .totalPages))              ?? 0
        movies = (try? values.decodeIfPresent([Movie].self, forKey: .movies))                  ?? []
    }
}

// MARK: - Result
struct Movie: Codable {
    var popularity: Double
    var voteCount: Int
    var video: Bool
    var posterPath: String
    var id: Int
    var adult: Bool
    var backdropPath, originalLanguage, originalTitle: String
    var genreIDS: [Int]
    var title: String
    var voteAverage: Double
    var overview, releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id, adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        popularity = (try? values.decodeIfPresent(Double.self, forKey: .popularity))                    ?? 0
        voteCount = (try? values.decodeIfPresent(Int.self, forKey: .voteCount))                         ?? 0
        video = (try? values.decodeIfPresent(Bool.self, forKey: .video))                                ?? false
        posterPath = (try? values.decodeIfPresent(String.self, forKey: .posterPath))                    ?? ""
        id = (try? values.decodeIfPresent(Int.self, forKey: .id))                                       ?? 0
        adult = (try? values.decodeIfPresent(Bool.self, forKey: .adult))                                ?? false
        backdropPath = (try? values.decodeIfPresent(String.self, forKey: .backdropPath))                ?? ""
        originalLanguage = (try? values.decodeIfPresent(String.self, forKey: .originalLanguage))        ?? ""
        originalTitle = (try? values.decodeIfPresent(String.self, forKey: .originalTitle))              ?? ""
        genreIDS = (try? values.decodeIfPresent([Int].self, forKey: .genreIDS))                         ?? []
        title = (try? values.decodeIfPresent(String.self, forKey: .title))                              ?? ""
        voteAverage = (try? values.decodeIfPresent(Double.self, forKey: .voteAverage))                  ?? 0
        overview = (try? values.decodeIfPresent(String.self, forKey: .overview))                        ?? ""
        releaseDate = (try? values.decodeIfPresent(String.self, forKey: .releaseDate))                  ?? ""
    }
}
