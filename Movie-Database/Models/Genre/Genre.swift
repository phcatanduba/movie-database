//
//  Genre.swift
//  Movie Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 05/07/22.
//

import Foundation

struct Genre: Equatable, Hashable, Codable {
    let id: Int
    let name: String
    
    init(id: Int, name: String = "") {
        self.id = id
        self.name = GenresRepository.current.genres[id]?.name ?? name
    }
}
