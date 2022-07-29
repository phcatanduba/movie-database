//
//  ImagesHandler.swift
//  Movie-Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 28/07/22.
//

import Foundation
import UIKit

struct Image: Codable {
    let path: String
    var data: Data
    
    var uiImage: UIImage {
        UIImage(data: data) ?? UIImage()
    }
}

