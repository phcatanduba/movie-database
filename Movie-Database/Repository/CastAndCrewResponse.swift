//
//  CastAndCrewResponse.swift
//  Movie-Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 03/08/22.
//

import Foundation

struct CastAndCrewResponse: Codable {
    var cast: [Actor]
}

struct Actor: Codable {
    let name: String
    let character: String
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case profilePath = "profile_path"
        case character
    }
}
