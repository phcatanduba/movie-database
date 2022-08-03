//
//  File.swift
//  Movie-Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 27/07/22.
//

import Foundation

class MoviesStore {
    static private let apiKey = "05c08d6250b844f0386ad2e517d26d8f"

    static private(set) var moviesNowPlaying: [Movie] = []
    static private(set) var moviesComingSoon: [Movie] = []
    
    let callback: () -> ()
    
    init(callback: @escaping () -> ()) {
        self.callback = callback
        request(type: .nowPlaying)
        request(type: .comingSoon)
    }
    
    private func saveJSON(movieUrl: URL, movies: [Movie]) {
        Store.shared.saveJSON(content: movies, url: movieUrl)
    }
    
    private func loadJSON(movieUrl: URL, movies: inout [Movie]) {
        guard let moviesDecoded = Store.shared.loadJSON(type: [Movie].self, url: movieUrl) else {
            print("Error in decoder \(Movie.self)")
            return
        }
        
        movies = moviesDecoded
    }
    
    private  func request(type: MovieType) {
        guard let url = type.url else { return }
        let decoder = JSONDecoder()
        
        Store.shared.getData(from: url) {data, response, error in
            guard let data = data else {
                return
            }
            
            guard response != nil else {
                return
            }

            guard let movies = try? decoder.decode(MoviesResponse.self, from: data) else {
                return
            }
            if type == .comingSoon {
                MoviesStore.moviesComingSoon = movies.results
            } else {
                MoviesStore.moviesNowPlaying = movies.results
            }
            
            DispatchQueue.main.async {
                self.callback()
            }
        }
    }
    
    static func requestDetails(id: Int, completion: @escaping (DetailsResponse) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(MoviesStore.apiKey)") else {
            return
        }
        
        let decoder = JSONDecoder()
        
        Store.shared.getData(from: url) { data, response, error in
            guard let data = data else {
                return
            }

            guard let detailsResponse = try? decoder.decode(DetailsResponse.self, from: data) else { return }
            
            DispatchQueue.main.async {
                completion(detailsResponse)
            }
        }
    }
    
    static func requestCastAndCrew(id: Int, completion: @escaping (CastAndCrewResponse) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=\(apiKey)") else {
            return
        }
        
        let decoder = JSONDecoder()
        
        Store.shared.getData(from: url) { data, response, error in
            guard let data = data else {
                return
            }

            guard let castAndCrewResponse = try? decoder.decode(CastAndCrewResponse.self, from: data) else { return }
            
            DispatchQueue.main.async {
                completion(castAndCrewResponse)
            }
        }
    }
    
    static func requestImages(id: Int, completion: @escaping (ImagesResponse) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/images?api_key=\(apiKey)") else {
            return
        }
        
        let decoder = JSONDecoder()
        
        Store.shared.getData(from: url) { data, response, error in
            guard let data = data else {
                return
            }

            guard let imagesResponse = try? decoder.decode(ImagesResponse.self, from: data) else { return }
            DispatchQueue.main.async {
                completion(imagesResponse)
            }
        }
    }
    
    enum MovieType {
        case comingSoon
        case nowPlaying
        
        var url: URL? {
            switch self {
                case .comingSoon: return URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(MoviesStore.apiKey)")
                case .nowPlaying: return URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(MoviesStore.apiKey)")
            }
        }
        
        var jsonURL: URL? {
            switch self {
                case .comingSoon: return URL(fileURLWithPath: "MoviesNowPlaying.json", relativeTo: FileManager.documentsDirectoryURL)
                case .nowPlaying: return URL(fileURLWithPath: "MoviesComingSoon.json", relativeTo: FileManager.documentsDirectoryURL)
            }
        }
    }
}

struct MoviesResponse: Codable {
    var results: [Movie]
}








