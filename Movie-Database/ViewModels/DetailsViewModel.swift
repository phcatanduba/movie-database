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
    var movie: Movie?
    private var repository: RepositoryProtocol
    
    init(repository: RepositoryProtocol = Repository()) {
        self.repository = repository
    }
    
    func start() {
        guard let id = movie?.id else { return }
        self.getCastAndCrew(id)
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
            self.photos.append(contentsOf: response.posters)
        }
    }
    
    func getGenreText() -> String? {
        movie?.genres.map({ genre in
            genre.name
        }).joined(separator: ", ")
    }
    
    func getOverview() -> String? {
        if let overview = movie?.overview {
            return overview + "\r\n"
        }
        
        return nil
    }
    
    func getTitle() -> String? {
        movie?.title
    }
    
    func getImageURL() -> URL? {
        URL(string: API.imagesURL + (movie?.backdropPath ?? ""))
    }
}
