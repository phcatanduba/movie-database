//
//  ImagesResponse.swift
//  Movie-Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 03/08/22.
//

import Foundation

struct ImagesResponse: Codable {
    let backdrops: [Image]
    let posters: [Image]
}

struct Image: Codable {
    let filePath: String
    
    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
}
