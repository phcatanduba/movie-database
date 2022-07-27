//
//  MovieViewModel.swift
//  Movie Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 05/07/22.
//

import Foundation

struct MoviesViewModel {
    
    var movies: [Movie]
    
    init(movies: [Movie]) {
        self.movies = movies
    }
    
    func getByGenre(genre: Genre) -> [Movie] {
        return movies.filter { movie in
            movie.genres.contains { movieGenre in
                movieGenre == genre
            }
        }
    }
    
    func sortByDate(order: (Date, Date) -> Bool) -> [Movie] {
        return movies.sorted(by: { order($0.releaseDate, $1.releaseDate) })
    }
    
    func sortByName() -> [Movie] {
        return movies.sorted(by: { $0.originalTitle.lowercased() < $1.originalTitle.lowercased() })
    }
}


