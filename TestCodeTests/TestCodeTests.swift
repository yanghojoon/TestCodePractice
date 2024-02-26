//
//  TestCodeTests.swift
//  TestCodeTests
//
//  Created by 양호준 on 2024/02/26.
//

import XCTest

final class TestCodeTests: XCTestCase {
    
    private func add(number1: Int, number2: Int) -> Int {
        number1 + number2
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let number1 = 1
        let number2 = 2
        
        let result = add(number1: number1, number2: number2)
        let expectation = 3
        
        XCTAssertEqual(result, expectation)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
