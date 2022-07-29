//
//  ImagesStore.swift
//  Movie-Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 28/07/22.
//

import Foundation

class ImagesStore {
    
    static let shared = ImagesStore()
    
    static var images: [String : Image] = [:]
    let rootURL = "https://image.tmdb.org/t/p/w500"
    
    func downloadImage(path: String, isLast: Bool) {
        guard let url = URL(string: rootURL + path) else { return }
        print("Download Started")
        Store.shared.getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            ImagesStore.images[path] = Image(path: path, data: data)
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name("NowPlayingReceived"), object: nil)
            }
        }
    }
}
