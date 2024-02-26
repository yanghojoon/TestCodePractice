//
//  StringConverter.swift
//  TestCode
//
//  Created by 양호준 on 2024/02/26.
//

import Foundation

final class StringConverter {
    var result: String = ""
    var dividedResult = [String]()
    
    func convertUppercased(_ text: String) {
        result = text.uppercased()
    }
    
    func divide(text: String, by standard: String = " ") {
        dividedResult = text.components(separatedBy: standard)
    }
}
