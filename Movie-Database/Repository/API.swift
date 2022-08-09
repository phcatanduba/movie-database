//
//  API.swift
//  Movie-Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 09/08/22.
//

import Foundation

class API {
    static private var key: String {
        "05c08d6250b844f0386ad2e517d26d8f"
    }
    
    static var imagesURL: String {
        "https://image.tmdb.org/t/p/w500"
    }
    
    static var genresURL: URL? {
        URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(key)")
    }
    
    static var comingSoonURL: String {
        "https://api.themoviedb.org/3/movie/upcoming?api_key=\(key)"
    }
    
    static var nowPlayingURL: String {
        "https://api.themoviedb.org/3/movie/now_playing?api_key=\(key)"
    }
    
    static func getImagesURLBy(_ id: Int) -> URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/images?api_key=\(API.key)") else {
            return URL(fileURLWithPath: "")
        }
        
        return url
    }
    
    static func getCastAndCrewURLBy(_ id: Int) -> URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=\(API.key)") else {
            return URL(fileURLWithPath: "")
        }
        
        return url
    }
    
    static func getDetailsURLBy(_ id: Int) -> URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=\(API.key)") else {
            return URL(fileURLWithPath: "")
        }
        
        return url
    }
}
