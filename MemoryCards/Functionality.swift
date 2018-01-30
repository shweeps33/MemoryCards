//
//  Functionality.swift
//  MemoryCards
//
//  Created by Admin on 15.01.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

public let levelNames = [("Easy", 6), ("Medium", 10), ("Hard", 14), ("Expert", 18)]

extension Double {
    mutating func roundTo(to: Double) -> Double {
        return Darwin.round(to * self)/to
    }
}

