//
//  Store.swift
//  Movie-Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 27/07/22.
//

import Foundation


class Store {
    
    static let shared = Store()
    
    func saveJSON<encodable: Encodable>(content: [encodable], url: URL) {
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(content)
            
           try data.write(to: url)

        } catch let error {
            print(error)
        }
    }
    
    func loadJSON<decodable: Decodable>(type: decodable.Type, url: URL) -> [decodable]? {
        let decoder = JSONDecoder()
        
        do {
            
            let data = try Data(contentsOf: url)
            
            let dataDecoded = try decoder.decode([decodable].self, from: data)
            return dataDecoded
        } catch let error {
            print(error)
        }
        
        return nil
    }
}
