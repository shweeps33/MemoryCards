//
//  Functionality.swift
//  MemoryCards
//
//  Created by Admin on 15.01.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import UIKit

public let levelNames = ["Easy", "Medium", "Hard", "Expert"]
public let levelNumbers = [8, 14, 20, 32]

func setBg(_ view: UIViewController) {
    let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    backgroundImage.image = #imageLiteral(resourceName: "bg")
    backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
    view.view.insertSubview(backgroundImage, at: 0)
}

extension Double {
    mutating func round(to: Double) -> Double {
        return Darwin.round(to * self)/to
    }
}
extension UIPickerView {
    func hideSelectionIndicator() {
        for i in [1, 2] {
            self.subviews[i].isHidden = true
        }
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
