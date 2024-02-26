//
//  NetworkMangerTests.swift
//  TestCodeTests
//
//  Created by 양호준 on 2024/02/26.
//

@testable import TestCode

import XCTest

final class NetworkMangerTests: XCTestCase {

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {
    }

    func test_잘못된_비동기_테스트() throws {
        // Given
        guard let url = URL(string: "https://csrng.net/csrng/csrng.php?min=0&max=50") else {
            XCTFail()
            return
        }
        
        // When
        let dataTask = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let data = data {
                do {
                    let randomNumber = try JSONDecoder().decode(RandomNumber.self, from: data)
                    
                    // Then
                    XCTAssertEqual(randomNumber.min, 0)
                } catch {
                    XCTFail()
                }
            } else {
                XCTFail()
            }
        }
        
        dataTask.resume()
    }
    
    func test_XCTestExpectation을_활용한_비동기_테스트() throws {
        let expectation = XCTestExpectation()
        
        // Given
        guard let url = URL(string: "https://csrng.net/csrng/csrng.php?min=0&max=50") else {
            XCTFail()
            return
        }
        
        // When
        let dataTask = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let data = data {
                do {
                    let randomNumber = try JSONDecoder().decode([RandomNumber].self, from: data)
                    
                    // Then
                    XCTAssertEqual(randomNumber.first?.min, 0)
                    
                    expectation.fulfill()
                } catch {
                    XCTFail()
                }
            } else {
                XCTFail()
            }
        }
        
        dataTask.resume()
        
        wait(for: [expectation], timeout: 3)
    }
}
