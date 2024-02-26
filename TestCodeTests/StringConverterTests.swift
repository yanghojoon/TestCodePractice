//
//  StringConverterTests.swift
//  TestCodeTests
//
//  Created by 양호준 on 2024/02/26.
//

@testable import TestCode

import XCTest

final class StringConverterTests: XCTestCase {
    private var sut: StringConverter!

    override func setUpWithError() throws {
        sut = StringConverter()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_convertUppercased를_통해_소문자만_있는_문자열을_대문자로_변환하는지() throws {
        // Given
        let defaultString = "abc"
        
        // When
        sut.convertUppercased(defaultString)
        
        // Then
        XCTAssertEqual(sut.result, "ABC")
        XCTAssertFalse(sut.result == "aBC")
    }
    
    func test_convertUppercased를_통해_한글_문자열을_그대로_결과에_넣는지() throws {
        // Given
        let defaultString = "가나다"
        
        // When
        sut.convertUppercased(defaultString)
        
        // Then
        XCTAssertEqual(sut.result, "가나다")
    }
    
    func test_divide를_통해_문자열을_띄워쓰기를_기준으로_배열로_쪼갤_수_있는지() throws {
        // Given
        let defaultString = "동해물과 백두산이 마르고 닳도록"
        
        // When
        sut.divide(text: defaultString)
        
        // Then
        XCTAssertEqual(sut.dividedResult, ["동해물과", "백두산이", "마르고", "닳도록"])
    }
}
