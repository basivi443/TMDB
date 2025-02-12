//
//  PopularPeopleModel.swift
//  TMDB
//
//  Created by Basivi Reddy on 12/02/25.
//

struct PopularPeopleModel: Codable {
    var page: Int?
    var results: [PeopleList]?
    var totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct PeopleList: Codable {
    var adult: Bool?
    var gender, id: Int?
    var knownForDepartment: KnownForDepartment?
    var name, originalName: String?
    var popularity: Double?
    var profilePath: String?
    var knownFor: [KnownFor]?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case knownFor = "known_for"
    }
}

// MARK: - KnownFor
struct KnownFor: Codable {
    var backdropPath: String?
    var id: Int?
    var title, originalTitle, overview, posterPath: String?
    var mediaType: MediaType?
    var adult: Bool?
    var originalLanguage: String?
    var genreIDS: [Int]?
    var popularity: Double?
    var releaseDate: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
    var name, originalName, firstAirDate: String?
    var originCountry: [String]?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id, title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case adult
        case originalLanguage = "original_language"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case name
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}

enum KnownForDepartment: String, Codable {
    case acting = "Acting"
}
