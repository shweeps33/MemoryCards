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
    let view = UIView()
    func makeFlip(){
        UIView.transition(with: self, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
    func changeCardState() {
        if self.isFlipped {
            labelForNumber.isHidden = false
            view.backgroundColor = UIColor.clear
            self.backgroundView = view
            self.backgroundColor = UIColor(red:0.85, green:0.96, blue:0.60, alpha:1.0)
        } else {
            labelForNumber.isHidden = true
            
            view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "cardsBack"))
            self.backgroundView = view
            self.backgroundView?.contentMode = .scaleAspectFit
            self.backgroundColor = UIColor(red:0.53, green:0.82, blue:0.68, alpha:1.0)
        }
    }
}
