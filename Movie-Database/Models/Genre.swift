//
//  Movie.swift
//  Movie Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 05/07/22.
//

import Foundation

struct Movie: Equatable {
    
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
    
    init(id: Int, voteAverage: Double, title: String, originalTitle: String, popularity: Double, posterPath: String, backdropPath: String, overview: String, releaseDate: String, genres: [Genre]) {
        self.id = id
        self.voteAverage = voteAverage
        self.title = title
        self.originalTitle = originalTitle
        self.popularity = popularity
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.overview = overview
        self.releaseDate = Date(dateString: releaseDate)
        self.genres = genres
    }
}

extension Date {
    init(dateString: String) {
        let formatter = DateFormatter()
        if let date = formatter.date(from: dateString) {
            self = date
        } else {
            self = Date()
        }
    }
}
