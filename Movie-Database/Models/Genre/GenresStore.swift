//
//  File.swift
//  Movie-Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 27/07/22.
//

import Foundation

class GenresStore {
    static private let apiKey = "05c08d6250b844f0386ad2e517d26d8f"
    private let genresURL = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)&language=en-US&page=1")

    static private(set) var genres: [Int : Genre] = [:]
    private let genresJsonURL = URL(fileURLWithPath: "Genres.json", relativeTo: FileManager.documentsDirectoryURL)
    
    init() {
        requestGenres()
    }
    
    private func saveJSON() {
        Store.shared.saveJSON(content: [GenresStore.genres], url: genresJsonURL)
    }
    
    private func loadJSON() {
        guard let genresDecoded = Store.shared.loadJSON(type: Genre.self, url: genresJsonURL) else {
            print("Error in decoder \(Genre.self)")
            return
        }
        
        genresDecoded.forEach { genre in
            GenresStore.genres[genre.id] = genre
        }
    }
    
    private  func requestGenres() {
        guard let url = genresURL else { return }
        let decoder = JSONDecoder()
        Store.shared.getData(from: url) { data, response, error in
            guard let data = data else {
                return
            }
            
            guard response != nil else {
                return
            }

            guard let result = try? decoder.decode(GenresResponse.self, from: data) else {
                return
            }
            
            result.genres.forEach { genre in
                GenresStore.genres[genre.id] = genre
            }
            
            MoviesStore()
            //self.loadJSON()
        }
    }
}

struct GenresResponse: Codable {
    var genres: [Genre]
}
