//
//  File.swift
//  Movie-Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 27/07/22.
//

import Foundation

struct MoviesResponse: Codable {
    var results: [Movie]
}

enum MovieType: Equatable {
    case comingSoon(_ page: Int)
    case nowPlaying(_ page: Int)
    
    var url: URL? {
        switch self {
            case .comingSoon(page: let page): return URL(string: "\(API.comingSoonURL)&page=\(page)")
            case .nowPlaying(page: let page): return URL(string: "\(API.nowPlayingURL)&page=\(page)")
        }
    }
    
    var jsonURL: URL? {
        switch self {
            case .comingSoon: return URL(fileURLWithPath: "MoviesNowPlaying.json", relativeTo: FileManager.documentsDirectoryURL)
            case .nowPlaying: return URL(fileURLWithPath: "MoviesComingSoon.json", relativeTo: FileManager.documentsDirectoryURL)
        }
    }
}










