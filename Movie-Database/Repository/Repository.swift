//
//  Store.swift
//  Movie-Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 27/07/22.
//

import Foundation
import UIKit

class Repository: RepositoryProtocol {
    static func saveJSON<encodable: Encodable>(content: encodable, url: URL) {
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(content)
            
           try data.write(to: url)

        } catch let error {
            print(error)
        }
    }
    
    static func loadJSON<decodable: Decodable>(type: decodable.Type, url: URL) -> decodable? {
        let decoder = JSONDecoder()
        
        do {
            
            let data = try Data(contentsOf: url)
            
            let dataDecoded = try decoder.decode(type.self, from: data)
            return dataDecoded
        } catch let error {
            print(error)
        }
        
        return nil
    }
    
    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func requestMovies(type: MovieType, completion: @escaping ([Movie]) -> ()) {
        guard let url = type.url else { return }
        let decoder = JSONDecoder()
        
        Repository.getData(from: url) { data, response, error in
            guard let data = data else {
                return
            }
            
            guard response != nil else {
                return
            }

            guard let movies = try? decoder.decode(MoviesResponse.self, from: data) else {
                return
            }
    
            DispatchQueue.main.async {
                completion(movies.results)
            }
        }
    }
    
    func requestDetails(id: Int, completion: @escaping (DetailsResponse) -> ()) {
        let url = API.getDetailsURLBy(id)
        
        let decoder = JSONDecoder()
        
        Repository.getData(from: url) { data, response, error in
            guard let data = data else {
                return
            }

            guard let detailsResponse = try? decoder.decode(DetailsResponse.self, from: data) else { return }
            
            DispatchQueue.main.async {
                completion(detailsResponse)
            }
        }
    }
    
    func requestPhotos(id: Int, completion: @escaping (ImagesResponse) -> ()) {
        let url = API.getImagesURLBy(id)
        
        let decoder = JSONDecoder()
        
        Repository.getData(from: url) { data, response, error in
            guard let data = data else {
                return
            }

            guard let imagesResponse = try? decoder.decode(ImagesResponse.self, from: data) else { return }
            DispatchQueue.main.async {
                completion(imagesResponse)
            }
        }
    }
    
    func requestCastAndCrew(id: Int, completion: @escaping (CastAndCrewResponse) -> ()) {
        let url = API.getCastAndCrewURLBy(id)
        
        let decoder = JSONDecoder()
        
        Repository.getData(from: url) { data, response, error in
            guard let data = data else {
                return
            }

            guard let castAndCrewResponse = try? decoder.decode(CastAndCrewResponse.self, from: data) else { return }
            
            DispatchQueue.main.async {
                completion(castAndCrewResponse)
            }
        }
    }
}

protocol RepositoryProtocol {
    func requestMovies(type: MovieType, completion: @escaping ([Movie]) -> ())
    func requestDetails(id: Int, completion: @escaping (DetailsResponse) -> ())
    func requestCastAndCrew(id: Int, completion: @escaping (CastAndCrewResponse) -> ())
    func requestPhotos(id: Int, completion: @escaping (ImagesResponse) -> ())
}
