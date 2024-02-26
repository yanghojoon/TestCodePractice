//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by 양호준 on 2024/02/26.
//

@testable import TestCode

import XCTest

final class CalculatorTests: XCTestCase {
    private var sut: Calculator!

    override func setUpWithError() throws {
        sut = Calculator()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testExample1() throws {
        // Given
        let number1 = 1
        let number2 = 2
        
        // When
        sut.add(number1: number1, number2: number2)
        
        // Then
        let expectation = 3
        
        XCTAssertEqual(sut.result, expectation)
    }

    func testExample2() throws {
        // Given
        let number1 = 4
        let number2 = 5
        
        // When
        sut.add(number1: number1, number2: number2)
        
        // Then
        let expectation = 9
        
        XCTAssertEqual(sut.result, expectation)
    }
}
