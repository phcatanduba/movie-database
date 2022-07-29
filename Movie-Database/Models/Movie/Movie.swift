//
//  Movie.swift
//  Movie Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 05/07/22.
//

import Foundation

struct Movie: Equatable, Hashable, Encodable, Decodable {
    
    let id: Int
    let voteAverage: Double
    let title: String
    let originalTitle: String
    let popularity: Double
    let posterPath: String
    let backdropPath: String
    let overview: String
    let releaseDate: Date
    let genres: [Genre]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        self.title = try container.decode(String.self, forKey: .title)
        self.originalTitle = try container.decode(String.self, forKey: .originalTitle)
        self.popularity = try container.decode(Double.self, forKey: .popularity)
        self.posterPath = try container.decode(String.self, forKey: .posterPath)
        self.backdropPath = try container.decode(String.self, forKey: .backdropPath)
        self.overview = try container.decode(String.self, forKey: .overview)
        let releaseDateString = try container.decode(String.self, forKey: .releaseDate)
        self.releaseDate = Date(dateString: releaseDateString)
        let genresId = try container.decode([Int].self, forKey: .genres)
        self.genres = genresId.map{ Genre(id: $0) }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case voteAverage = "vote_average"
        case title
        case originalTitle = "original_title"
        case popularity
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case overview
        case releaseDate = "release_date"
        case genres = "genre_ids"
    }
    
    
}


