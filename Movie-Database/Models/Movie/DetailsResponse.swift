//
//  DetailsResponse.swift
//  Movie-Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 03/08/22.
//

import Foundation

struct DetailsResponse: Codable {
    var runtime: Int
    var adult: Bool
    
    var duration: String {
        let time = self.runtime
        let hours = time / 60
        let mins = time % 60
        let timeInText = "\(hours)h \(mins)m | \(adult ? "R" : "G")"
        return timeInText
    }
}
