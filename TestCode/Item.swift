//
//  Item.swift
//  TestCode
//
//  Created by 양호준 on 2024/02/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
