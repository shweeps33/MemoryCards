//
//  CollectionViewCell.swift
//  MemoryCards
//
//  Created by Admin on 09.01.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var labelForNumber: UILabel!
    var isFlipped = false {
        didSet {
            changeCardState()
        }
    }
    func makeFlip(){
        UIView.transition(with: self, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    func changeCardState() {
        if self.isFlipped {
            labelForNumber.isHidden = false
            self.backgroundColor = UIColor(red:0.77, green:0.77, blue:0.77, alpha:1.0)
        } else {
            labelForNumber.isHidden = true
            self.backgroundColor = UIColor(red:0.56, green:0.74, blue:0.87, alpha:1.0)
        }
    }
}
