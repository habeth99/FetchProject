//
//  NetworkingService.swift
//  FetchProject
//
//  Created by Nick Habeth on 10/7/24.
//

import Foundation
import Combine

protocol NetworkService {
    func fetch(from url: URL) -> AnyPublisher<URLSession.DataTaskPublisher.Output, Error>
}

class URLSessionNetworkService: NetworkService {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetch(from url: URL) -> AnyPublisher<URLSession.DataTaskPublisher.Output, Error> {
        return session.dataTaskPublisher(for: url)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}

class MockNetworkService: NetworkService {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?
    
    func fetch(from url: URL) -> AnyPublisher<URLSession.DataTaskPublisher.Output, Error> {
        return Future<URLSession.DataTaskPublisher.Output, Error> { promise in
            if let error = self.mockError {
                promise(.failure(error))
            } else if let data = self.mockData, let response = self.mockResponse {
                promise(.success((data, response)))
            } else {
                promise(.failure(URLError(.unknown)))
            }
        }.eraseToAnyPublisher()
    }
}
