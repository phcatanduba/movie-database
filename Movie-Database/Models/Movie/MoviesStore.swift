//
//  File.swift
//  Movie-Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 27/07/22.
//

import Foundation

class MoviesStore {
    static private let apiKey = "05c08d6250b844f0386ad2e517d26d8f"
    private let nowPlayingURL = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&language=en-US")

    static private(set) var movies: [Movie] = []
    
    private let moviesJsonURL = URL(fileURLWithPath: "Movies.json", relativeTo: FileManager.documentsDirectoryURL)
    
    init() {
        requestNowPlaying()
    }
    
    private func saveJSON() {
        Store.shared.saveJSON(content: [MoviesStore.movies], url: moviesJsonURL)
    }
    
    private func loadJSON() {
        guard let moviesDecoded = Store.shared.loadJSON(type: Movie.self, url: moviesJsonURL) else {
            print("Error in decoder \(Movie.self)")
            return
        }
        
        MoviesStore.movies = moviesDecoded
    }
    
    private  func requestNowPlaying() {
        guard let url = nowPlayingURL else { return }
        let decoder = JSONDecoder()
        
        let urlSession = URLSession(configuration: .default)
        urlSession.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            
            guard response != nil else {
                return
            }

            guard let movies = try? decoder.decode(MoviesResponse.self, from: data) else {
                return
            }
            
            MoviesStore.movies = movies.results
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name("NowPlayingReceived"), object: nil)
            }
            //self.loadJSON()
        }.resume()
    }
}

struct MoviesResponse: Codable {
    var results: [Movie]
}
