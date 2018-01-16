//
//  Functionality.swift
//  MemoryCards
//
//  Created by Admin on 15.01.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

extension Double {
    mutating func roundTo(to: Double) -> Double {
        return Darwin.round(to * self)/to
    }
}

