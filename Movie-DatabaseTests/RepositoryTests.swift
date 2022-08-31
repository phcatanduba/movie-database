//
//  RepositoryTests.swift
//  Movie-DatabaseTests
//
//  Created by Pedro Henrique Catanduba de Andrade on 31/08/22.
//

import XCTest
@testable import Movie_Database

class RepositoryTests: XCTestCase {
    var repository: Repository!
    var mockUrlSession: MockURLSession!
    
    override func setUp() async throws {
        mockUrlSession =  MockURLSession()
        self.repository = Repository(urlSession: mockUrlSession)
    }
    
    func testRequestMovies() {
        repository.requestMovies(type: .comingSoon(1)) { _ in }
        XCTAssertEqual(mockUrlSession.nextDataTask.count, 1)
    }
    
    func testRequestPhotos() {
        repository.requestPhotos(id: 1) { _ in }
        XCTAssertEqual(mockUrlSession.nextDataTask.count, 1)
    }
    
    func testRequestDetails() {
        repository.requestDetails(id: 1) { _ in }
        XCTAssertEqual(mockUrlSession.nextDataTask.count, 1)
    }
    
    func testRequestCastAndCrew() {
        repository.requestCastAndCrew(id: 1) { _ in }
        XCTAssertEqual(mockUrlSession.nextDataTask.count, 1)
    }
    

}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    var count = 0
    
    func resume() {
        count += 1
    }
}

class MockURLSession: URLSessionProtocol {
    var nextDataTask = MockURLSessionDataTask()
    var lastURL: URL?

    func dataTaskWithURL(_ url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) -> URLSessionDataTaskProtocol {
        lastURL = url
        completion(nil, nil, nil)
        return nextDataTask
    }
}







