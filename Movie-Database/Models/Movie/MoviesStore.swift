//
//  File.swift
//  Movie-Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 27/07/22.
//

import Foundation

class MoviesStore {
    private(set) var movies: [Movie] = []
    
    private let moviesJsonURL = URL(fileURLWithPath: "Movies.json", relativeTo: FileManager.documentsDirectoryURL)
    
    init() {
        loadJSON()
    }
    
    private func saveJSON() {
        Store.shared.saveJSON(content: [movies], url: moviesJsonURL)
    }
    
    private func loadJSON() {
        guard let moviesDecoded = Store.shared.loadJSON(type: Movie.self, url: moviesJsonURL) else {
            print("Error in decoder \(Movie.self)")
            return
        }
        
        movies = moviesDecoded
    }
}
