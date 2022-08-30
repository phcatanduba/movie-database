//
//  DetailsViewModelTests.swift
//  Movie-DatabaseTests
//
//  Created by Pedro Henrique Catanduba de Andrade on 30/08/22.
//

import XCTest
@testable import Movie_Database

class DetailsViewModelTests: XCTestCase {
    
    var repositoryMock: RepositoryMock!
    var viewModel: DetailsViewModel!
    
    override func setUp() {
        repositoryMock = RepositoryMock()
        viewModel = DetailsViewModel(repository: repositoryMock)
        viewModel.movie = Movie(id: 1, voteAverage: 1, title: "title", originalTitle: "originalTitile", popularity: 0.0, posterPath: "posterPath", backdropPath: "backdropPath", overview: "overview", releaseDate: "releaseDate", genres: [repositoryMock.terror, repositoryMock.romance, repositoryMock.musical])
        viewModel.start()
    }
    
    func testCastAndCrew() {
        let castAndCrewResponse = [Actor(name: "name", character: "character", profilePath: "profilePath")]
        XCTAssertEqual(viewModel.castAndCrew, castAndCrewResponse)
    }
    
    func testPhotos() {
        let imagesResponse = [Image(filePath: "backdrops"), Image(filePath: "posters")]
        XCTAssertEqual(viewModel.photos, imagesResponse)
    }
    
    func testGenreText() {
        XCTAssertEqual(viewModel.getGenreText(), "terror, romance, musical")
    }
    
    func testOverview() {
        XCTAssertEqual(viewModel.getOverview(), "overview\r\n")
    }
    
    func testTitle() {
        XCTAssertEqual(viewModel.getTitle(), "title")
    }
    
    func testImageURL() {
        XCTAssertEqual(viewModel.getImageURL(), URL(string: API.imagesURL + "backdropPath"))
    }
    
    func testMovieNil() {
        let viewModelMovieNil = DetailsViewModel(repository: repositoryMock)
        viewModelMovieNil.start()
        XCTAssertEqual(viewModelMovieNil.getTitle(), nil)
        XCTAssertEqual(viewModelMovieNil.getOverview(), nil)
        XCTAssertEqual(viewModelMovieNil.getImageURL(), URL(string: API.imagesURL))
        XCTAssertEqual(viewModelMovieNil.getGenreText(), nil)
        XCTAssertEqual(viewModelMovieNil.photos, [])
        XCTAssertEqual(viewModelMovieNil.castAndCrew, [])
    }
}
