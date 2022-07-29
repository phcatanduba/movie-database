//
//  Genre.swift
//  Movie Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 05/07/22.
//

import Foundation

struct Genre: Equatable, Hashable, Encodable, Decodable {
    let id: Int
    let name: String
    
    init(id: Int) {
        self.id = id
        self.name = GenresStore.genres[id]?.name ?? ""
    }
}
