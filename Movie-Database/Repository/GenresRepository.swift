//
//  File.swift
//  Movie-Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 27/07/22.
//

import Foundation

class GenresRepository {
    
    static let current = GenresRepository()
    
    var genres: [Int : Genre] = [:]
    
    private init() {
        requestGenres()
    }
    
    private var genresJsonURL: URL {
        URL(fileURLWithPath: "Genres.json", relativeTo: FileManager.documentsDirectoryURL)
    }
    
    private func saveJSON() {
        Repository.saveJSON(content: genres, url: genresJsonURL)
    }
    
    private func loadJSON() -> [Int : Genre]? {
        guard let genresDecoded = Repository.loadJSON(type: [Int : Genre].self, url: genresJsonURL) else {
            print("Error in decoder \(Genre.self)")
            return nil
        }

        genres = genresDecoded
        
        return nil
    }
    
    private func requestGenres() {
        guard let url = API.genresURL else { return }
        let decoder = JSONDecoder()
        
        if loadJSON() == nil {
            Repository.getData(from: url) { data, response, error in
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
                    self.genres[genre.id] = genre
                }
                
                self.saveJSON()
            }
        }
    }
}

struct GenresResponse: Codable {
    var genres: [Genre]
}
