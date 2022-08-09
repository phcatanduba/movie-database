//
//  DetailsViewModel.swift
//  Movie-Database
//
//  Created by Pedro Henrique Catanduba de Andrade on 09/08/22.
//

import Foundation

class DetailsViewModel {
    @Published var castAndCrew: [Actor] = []
    @Published var photos: [Image] = []
    var movie: Movie
    private var repository: Repository
    
    init(movie: Movie, repository: Repository = Repository()) {
        self.repository = repository
        self.movie = movie
    }
    
    func start() {
        let id = movie.id
        self.getCastAndCrew(id)
        self.getDetails(id)
        self.getPhotos(id)
    }
    
    private func getCastAndCrew(_ id: Int) {
        repository.requestCastAndCrew(id: id) { response in
            self.castAndCrew.append(contentsOf: response.cast)
        }
    }
    
    private func getPhotos(_ id: Int) {
        repository.requestPhotos(id: id) { response in
            self.photos.append(contentsOf: response.backdrops)
        }
    }
    
    private func getDetails(_ id: Int) {
        repository.requestDetails(id: id) { response in
           //self.duration = response.duration
        }
    }
}
