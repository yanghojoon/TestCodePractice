//
//  Calculator.swift
//  TestCode
//
//  Created by 양호준 on 2024/02/26.
//

import Foundation

final class Calculator {
    func add(number1: Int, number2: Int) -> Int {
        number1 + number2
    }
    
    private func printResult() {
        print(add(number1: 3, number2: 4))
    }
    
    fileprivate func printResult2() {
        print(add(number1: 3, number2: 4))
    }
}
