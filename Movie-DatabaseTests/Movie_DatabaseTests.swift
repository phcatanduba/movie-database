//
//  Movie_DatabaseTests.swift
//  Movie-DatabaseTests
//
//  Created by Pedro Henrique Catanduba de Andrade on 12/07/22.
//

import XCTest
@testable import Movie_Database

class Movie_DatabaseTests: XCTestCase {

    let movieTest = MovieTest()
    
    func testGetByGenre() throws {
        let romanceList = movieTest.movieViewModel.getByGenre(genre: movieTest.romance)
        let terrorList = movieTest.movieViewModel.getByGenre(genre: movieTest.terror)
        let musicalList = movieTest.movieViewModel.getByGenre(genre: movieTest.musical)
    
        XCTAssertTrue(romanceList == movieTest.movieViewModel.movies)
        XCTAssertTrue(terrorList == [movieTest.movieOne, movieTest.movieThree])
        XCTAssertTrue(musicalList == [movieTest.movieTwo])
    }
    
    func testSortByName() {
        XCTAssertEqual(movieTest.movieViewModel.sortByName(), [movieTest.movieTwo, movieTest.movieThree, movieTest.movieOne])
    }
    
    func testSortByDate() {
        XCTAssertEqual(movieTest.movieViewModel.sortByDate(order: <), [movieTest.movieTwo, movieTest.movieThree, movieTest.movieOne])
        
        XCTAssertEqual(movieTest.movieViewModel.sortByDate(order: >), [movieTest.movieOne, movieTest.movieThree, movieTest.movieTwo])
    }
}

class MovieTest {
    let romance = Genre(id: 1, name: "romance")
    let terror = Genre(id: 0, name: "terror")
    let musical = Genre(id: 2, name: "musical")
    
    let movieOne: Movie
    let movieTwo: Movie
    let movieThree: Movie
    
    let movieViewModel: MovieViewModel
    
    init() {
        movieOne =  Movie(id: 1, voteAverage: 2, title: "madagascar", originalTitle: "madagascar", popularity: 10, posterPath: "posterPath", backdropPath: "backdropPath", overview: "overview", releaseDate: "2000-07-18", genres: [terror, romance])
        movieTwo = Movie(id: 2, voteAverage: 2, title: "madagascar", originalTitle: "aadagascar", popularity: 10, posterPath: "posterPath", backdropPath: "backdropPath", overview: "overview", releaseDate: "1994-07-17", genres: [musical, romance])
        movieThree = Movie(id: 3, voteAverage: 2, title: "madagascar", originalTitle: "badagascar", popularity: 10, posterPath: "posterPath", backdropPath: "backdropPath", overview: "overview", releaseDate: "1996-07-16", genres: [terror, romance])
        movieViewModel = MovieViewModel(movies:[movieOne, movieTwo, movieThree])
    }
}
