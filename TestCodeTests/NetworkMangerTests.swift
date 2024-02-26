//
//  NetworkMangerTests.swift
//  TestCodeTests
//
//  Created by 양호준 on 2024/02/26.
//

@testable import TestCode

import XCTest

final class NetworkMangerTests: XCTestCase {
    var sut: NetworkManager!

    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        
        let mockURLSession = URLSession(configuration: configuration)
        
        sut = NetworkManager(urlSession: mockURLSession)
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
    
    func test_testDouble을_활용한_비동기_테스트() {
        // Given
        let expectation = XCTestExpectation()
        
        guard
            let path = Bundle(for: type(of: self)).path(forResource: "StubRandomNumber", ofType: "json"),
            let jsonString = try? String(contentsOfFile: path)
        else {
            XCTFail()

            return
        }
        
        let data = jsonString.data(using: .utf8)
        let stubResponse = HTTPURLResponse(
            url: URL(string: "https://csrng.net/csrng/csrng.php?min=0&max=50")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        MockURLProtocol.requestHandler = { request in
            return (stubResponse!, data!)
        }
        
        // When
        sut?.fetchData(url: URL(string: "https://csrng.net/csrng/csrng.php?min=0&max=100")!, decodingType: [RandomNumber].self, completionHandler: { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.first?.min, 0)
                XCTAssertEqual(data.first?.max, 50)
                XCTAssertEqual(data.first?.status, "success")
                XCTAssertEqual(data.first?.random, 6)
                
                expectation.fulfill()
            case .failure(let error):
                XCTFail()
            }
        })
        
        wait(for: [expectation], timeout: 0.01)
    }
}
