//
//  Movie.swift
//
//
//  Created by Leonardo Mendez on 27/05/24.
//

import Foundation

public struct MovieResponse: Codable {
    public let averageRating: Double?
    public let backdropPath: String?
    public let results: [Movie]
    public let comments: Comments?
    public let createdBy: CreatedBy?
    public let description: String?
    public let id: Int?
    public let iso3166_1: String?
    public let iso639_1: String?
    public let itemCount: Int?
    public let name: String?
    public let objectIDS: ObjectIDS?
    public let page: Int?
    public let posterPath: String?
    public let moviePublic: Bool?
    public let revenue, runtime: Int?
    public let sortBy: String?
    public let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case averageRating = "average_rating"
        case backdropPath = "backdrop_path"
        case results, comments
        case createdBy = "created_by"
        case description, id
        case iso3166_1 = "iso_3166_1"
        case iso639_1 = "iso_639_1"
        case itemCount = "item_count"
        case name
        case objectIDS = "object_ids"
        case page
        case posterPath = "poster_path"
        case moviePublic = "public"
        case revenue, runtime
        case sortBy = "sort_by"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

public struct Comments: Codable {
    public let movie617127, movie986056, movie822119, movie533535: JSONNull?
    public let movie609681, movie447365, movie640146, movie505642: JSONNull?
    public let movie616037, movie453395, movie634649, movie524434: JSONNull?
    public let movie566525, movie497698, movie429617, movie299534: JSONNull?
    public let movie299537, movie363088, movie299536, movie284054: JSONNull?

    enum CodingKeys: String, CodingKey {
        case movie617127 = "movie:617127"
        case movie986056 = "movie:986056"
        case movie822119 = "movie:822119"
        case movie533535 = "movie:533535"
        case movie609681 = "movie:609681"
        case movie447365 = "movie:447365"
        case movie640146 = "movie:640146"
        case movie505642 = "movie:505642"
        case movie616037 = "movie:616037"
        case movie453395 = "movie:453395"
        case movie634649 = "movie:634649"
        case movie524434 = "movie:524434"
        case movie566525 = "movie:566525"
        case movie497698 = "movie:497698"
        case movie429617 = "movie:429617"
        case movie299534 = "movie:299534"
        case movie299537 = "movie:299537"
        case movie363088 = "movie:363088"
        case movie299536 = "movie:299536"
        case movie284054 = "movie:284054"
    }
}

public struct CreatedBy: Codable {
    public let avatarPath, gravatarHash, id, name: String
    public let username: String

    enum CodingKeys: String, CodingKey {
        case avatarPath = "avatar_path"
        case gravatarHash = "gravatar_hash"
        case id, name, username
    }
}

public struct ObjectIDS: Codable {
}

public struct Movie: Codable {
    public let backdropPath: String?
    public let id: Int?
    public let originalTitle, overview, posterPath: String?
    public let mediaType: MediaType?
    public let adult: Bool?
    public let title: String?
    public let originalLanguage: String? // Cambiado a String
    public let genreIDS: [Int]?
    public let popularity: Double?
    public let releaseDate: String?
    public let video: Bool?
    public let voteAverage: Double?
    public let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case adult, title
        case originalLanguage = "original_language"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

public enum MediaType: String, Codable {
    case movie = "movie"
}

public class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}
