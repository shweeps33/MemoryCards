//
//  Functionality.swift
//  MemoryCards
//
//  Created by Admin on 15.01.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

public let levelNames = [("Easy", 8), ("Medium", 14), ("Hard", 22), ("Expert", 32)]

extension Double {
    mutating func roundTo(to: Double) -> Double {
        return Darwin.round(to * self)/to
    }
}
extension Array {
    mutating func shuffle() -> Array {
        for i in 0 ..< (count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            swapAt(i, j)
        }
        return self
    }
}
