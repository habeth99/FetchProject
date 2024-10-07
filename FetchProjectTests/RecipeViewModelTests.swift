//
//  RecipeViewModelTests.swift
//  FetchProjectTests
//
//  Created by Nick Habeth on 10/6/24.
//

import Foundation
import Combine
import XCTest
@testable import FetchProject

class RecipeViewModelTests: XCTestCase {
    var sut: RecipeViewModel!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        sut = RecipeViewModel(networkService: mockNetworkService)
    }
    
    override func tearDown() {
        sut = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    func testFetchRecipesSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch recipes")
        let mockData = """
        {
            "recipes": [
                {
                    "cuisine": "Malaysian",
                    "name": "Apam Balik",
                    "photo_url_large": "https://example.com/large.jpg",
                    "photo_url_small": "https://example.com/small.jpg",
                    "source_url": "https://example.com/recipe",
                    "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                    "youtube_url": "https://youtube.com/watch?v=12345"
                },
                {
                    "cuisine": "British",
                    "name": "Apple & Blackberry Crumble",
                    "photo_url_large": "https://example.com/large2.jpg",
                    "photo_url_small": "https://example.com/small2.jpg",
                    "source_url": "https://example.com/recipe2",
                    "uuid": "599344f4-3c5c-4cca-b914-2210e3b3312f",
                    "youtube_url": "https://youtube.com/watch?v=67890"
                }
            ]
        }
        """.data(using: .utf8)!
        mockNetworkService.mockData = mockData
        mockNetworkService.mockResponse = HTTPURLResponse(url: URL(string: "https://example.com/recipes.json")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        // When
        sut.fetchRecipes()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.sut.recipes.count, 2)
            XCTAssertEqual(self.sut.recipes[0].name, "Apam Balik")
            XCTAssertEqual(self.sut.recipes[1].name, "Apple & Blackberry Crumble")
            XCTAssertNil(self.sut.error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchRecipesFailure() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch recipes failure")
        mockNetworkService.mockError = NSError(domain: "TestError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Test network error"])

        // When
        sut.fetchRecipes()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.sut.recipes.isEmpty)
            XCTAssertNotNil(self.sut.error)
            XCTAssertEqual(self.sut.error, "Error fetching recipes: Test network error")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testFetchRecipesEmptyResponse() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch empty recipes")
        let mockData = """
        {
            "recipes": []
        }
        """.data(using: .utf8)!
        mockNetworkService.mockData = mockData
        mockNetworkService.mockResponse = HTTPURLResponse(url: URL(string: "https://example.com/recipes.json")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        // When
        sut.fetchRecipes()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.sut.recipes.isEmpty)
            XCTAssertNil(self.sut.error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }

    func testFetchRecipesInvalidJSON() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch recipes with invalid JSON")
        let invalidJSONData = "Invalid JSON".data(using: .utf8)!
        mockNetworkService.mockData = invalidJSONData
        mockNetworkService.mockResponse = HTTPURLResponse(url: URL(string: "https://example.com/recipes.json")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        // When
        sut.fetchRecipes()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.sut.recipes.isEmpty)
            XCTAssertNotNil(self.sut.error)
            XCTAssertTrue(self.sut.error?.contains("Error fetching recipes:") ?? false)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
}



