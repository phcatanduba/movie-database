//
//  Movie_DatabaseTests.swift
//  Movie-DatabaseTests
//
//  Created by Pedro Henrique Catanduba de Andrade on 12/07/22.
//

import XCTest
@testable import Movie_Database

class MoviesViewModelTests: XCTestCase {

    var repositoryMock: RepositoryMock!
    var viewModel: MoviesViewModel!
    
    override func setUp() async throws {
        repositoryMock = RepositoryMock()
        viewModel = MoviesViewModel(repository: repositoryMock)
        viewModel.start()
    }
    
    func testGetByGenre() throws {
        let romanceList = viewModel.getByGenre(genre: repositoryMock.romance)
        let terrorList = viewModel.getByGenre(genre: repositoryMock.terror)
        let musicalList = viewModel.getByGenre(genre: repositoryMock.musical)
    
        XCTAssertTrue(romanceList == repositoryMock.romanceList)
        XCTAssertTrue(terrorList == repositoryMock.terrorList)
        XCTAssertTrue(musicalList == repositoryMock.musicalList)
    }
    
    func testSortByName() {
        XCTAssertEqual(viewModel.sortByName(), repositoryMock.sortByName)
    }
    
    func testSortByDate() {
        XCTAssertEqual(viewModel.sortByDate(order: <), [repositoryMock.movieTwo, repositoryMock.movieThree, repositoryMock.movieOne])
        
        XCTAssertEqual(viewModel.sortByDate(order: >), [repositoryMock.movieOne, repositoryMock.movieThree, repositoryMock.movieTwo])
    }
    
    func  testNextPage() {
        let previousPage = viewModel.page
        viewModel.nextPage()
        let currentPage = previousPage + 1
        
        XCTAssertEqual(previousPage, currentPage - 1)
    }
}

class RepositoryMock: RepositoryProtocol {
    let nowPlaying: [Movie]
    let comingSoon: [Movie]
    
    let sortByName: [Movie]
    
    let romanceList: [Movie]
    let terrorList: [Movie]
    let musicalList: [Movie]

    let terror = Genre(id: 0, name: "terror")
    let romance = Genre(id: 1, name: "romance")
    let musical = Genre(id: 2, name: "musical")
    
    let movieOne: Movie
    let movieTwo: Movie
    let movieThree: Movie
    
    init() {
        movieOne =  Movie(id: 1, voteAverage: 2, title: "madagascar", originalTitle: "madagascar", popularity: 10, posterPath: "posterPath", backdropPath: "backdropPath", overview: "overview", releaseDate: "2000-07-18", genres: [terror, romance])
        movieTwo = Movie(id: 2, voteAverage: 2, title: "madagascar", originalTitle: "aadagascar", popularity: 10, posterPath: "posterPath", backdropPath: "backdropPath", overview: "overview", releaseDate: "1994-07-17", genres: [musical, romance])
        movieThree = Movie(id: 3, voteAverage: 2, title: "madagascar", originalTitle: "badagascar", popularity: 10, posterPath: "posterPath", backdropPath: "backdropPath", overview: "overview", releaseDate: "1996-07-16", genres: [terror, romance])
        
        comingSoon = []
        nowPlaying = [movieOne, movieTwo, movieThree]
        sortByName = [movieTwo, movieThree, movieOne]
        romanceList = [movieOne, movieTwo, movieThree]
        terrorList = [movieOne, movieThree]
        musicalList = [movieTwo]
    }
    
    func requestMovies(type: MovieType, completion: @escaping ([Movie]) -> ()) {
        switch type {
        case .comingSoon( _):
            completion(comingSoon)
        case .nowPlaying( _):
            completion(nowPlaying)
        }
    }
    
    func requestDetails(id: Int, completion: @escaping (DetailsResponse) -> ()) {
        
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        
    }
    
    func requestCastAndCrew(id: Int, completion: @escaping (CastAndCrewResponse) -> ()) {
        completion(CastAndCrewResponse(cast: [Actor(name: "name", character: "character", profilePath: "profilePath")]))
    }
    
    func requestPhotos(id: Int, completion: @escaping (ImagesResponse) -> ()) {
        completion(ImagesResponse(backdrops: [Image(filePath: "backdrops")], posters: [Image(filePath: "posters")]))
    }
}
