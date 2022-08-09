//
//  MovieViewModel.swift
//  Movie Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 05/07/22.
//

import Foundation

class MoviesViewModel {
    
    @Published var comingSoon: [Movie] = []
    @Published var nowPlaying: [Movie] = []
    
    var castAndCrew: [Actor] = []
    var duration: String = ""
    var photos: [Image] = []
    var selectedMovie: Movie?
    
    var isComingSoon: Bool = false
    
    var movies: [Movie] {
        isComingSoon ? comingSoon : nowPlaying
    }
    
    private var page: Int = 1
    private let repository: Repository
    
    init(repository: Repository = Repository()) {
        self.repository = repository
        self.getAllMoviesType()
    }
    
    private func getAllMoviesType() {
        repository.requestMovies(type: .comingSoon(page)) { response in
            self.comingSoon.append(contentsOf: response)
        }
        
        repository.requestMovies(type: .nowPlaying(page)) { response in
            self.nowPlaying.append(contentsOf: response)
        }
    }
    
    func nextPage() {
        page += 1
        getAllMoviesType()
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


