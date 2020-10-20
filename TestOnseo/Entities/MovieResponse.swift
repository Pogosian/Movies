//
//  MovieResponse.swift
//  TestOnseo
//
//  Created by Oleg Pogosian on 04.07.2020.
//  Copyright © 2020 Oleg Pogosian All rights reserved.
//

import Foundation

// MARK: - MovieResponse
struct MovieResponse: Codable {
    var adult: Bool
    var backdropPath: String
    var budget: Int
    var genres: [Genre]
    var homepage: String
    var id: Int
    var imdbID, originalLanguage, originalTitle, overview: String
    var popularity: Double
    var posterPath: String
    var productionCountries: [ProductionCountry]
    var releaseDate: String
    var revenue, runtime: Int
    var spokenLanguages: [SpokenLanguage]
    var status, tagline, title: String
    var video: Bool
    var voteAverage: Double
    var voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    init(from decoder: Decoder){
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        
        adult = (try? values?.decodeIfPresent(Bool.self, forKey: .adult))                            ?? false
        backdropPath = (try? values?.decodeIfPresent(String.self, forKey: .backdropPath))            ?? ""
        budget = (try? values?.decodeIfPresent(Int.self, forKey: .budget))                           ?? 0
        genres = (try? values?.decodeIfPresent([Genre].self, forKey: .genres))                       ?? []
        homepage = (try? values?.decodeIfPresent(String.self, forKey: .homepage))                    ?? ""
        id = (try? values?.decodeIfPresent(Int.self, forKey: .id))                                   ?? 0
        imdbID = (try? values?.decodeIfPresent(String.self, forKey: .imdbID))                        ?? ""
        originalLanguage = (try? values?.decodeIfPresent(String.self, forKey: .originalLanguage))    ?? ""
        originalTitle = (try? values?.decodeIfPresent(String.self, forKey: .originalTitle))          ?? ""
        overview = (try? values?.decodeIfPresent(String.self, forKey: .overview))                    ?? ""
        popularity = (try? values?.decodeIfPresent(Double.self, forKey: .popularity))                ?? 0
        posterPath = (try? values?.decodeIfPresent(String.self, forKey: .posterPath))                ?? ""
        productionCountries = (try? values?.decodeIfPresent([ProductionCountry].self, forKey: .productionCountries))                    ?? []
        releaseDate = (try? values?.decodeIfPresent(String.self, forKey: .releaseDate))              ?? ""
        revenue = (try? values?.decodeIfPresent(Int.self, forKey: .revenue))                         ?? 0
        runtime = (try? values?.decodeIfPresent(Int.self, forKey: .runtime))                         ?? 0
        spokenLanguages = (try? values?.decodeIfPresent([SpokenLanguage].self, forKey: .spokenLanguages))  ?? []
        status = (try? values?.decodeIfPresent(String.self, forKey: .status))                        ?? ""
        tagline = (try? values?.decodeIfPresent(String.self, forKey: .tagline))                      ?? ""
        title = (try? values?.decodeIfPresent(String.self, forKey: .title))                          ?? ""
        video = (try? values?.decodeIfPresent(Bool.self, forKey: .video))                            ?? false
        voteAverage = (try? values?.decodeIfPresent(Double.self, forKey: .voteAverage))              ?? 0
        voteCount = (try? values?.decodeIfPresent(Int.self, forKey: .voteCount))                     ?? 0
    }
}

// MARK: - Genre
struct Genre: Codable {
    var id: Int
    var name: String
    
    init(from decoder: Decoder){
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        
        id = (try? values?.decodeIfPresent(Int.self, forKey: .id))                              ?? 0
        name = (try? values?.decodeIfPresent(String.self, forKey: .name))                       ?? ""
    }
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    var iso3166_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
    
    init(from decoder: Decoder){
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        
        iso3166_1 = (try? values?.decodeIfPresent(String.self, forKey: .iso3166_1))             ?? ""
        name = (try? values?.decodeIfPresent(String.self, forKey: .name))                       ?? ""
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    var iso639_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case name
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        iso639_1 = (try? values.decodeIfPresent(String.self, forKey: .iso639_1))               ?? ""
        name = (try? values.decodeIfPresent(String.self, forKey: .name))                       ?? ""
    }
}
