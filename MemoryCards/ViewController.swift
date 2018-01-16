//
//  ViewController.swift
//  MemoryCards
//
//  Created by Admin on 09.01.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import GameplayKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var numberPicker: UIPickerView!
    @IBAction func startButton(_ sender: UIButton) {
        let cardsVC = storyboard?.instantiateViewController(withIdentifier: "CardsVC") as! CardsViewController
        cardsVC.numberOfCards = selectedNumber
        
        var array = [Int]()
        for i in 0..<selectedNumber/2 {
            array.append(i+1)
        }
        array += array
        cardsVC.arrayOfNumbers = array.shuffle()
        navigationController?.pushViewController(cardsVC, animated: true)
    }
    
    
    let baseNumber = 6
    var selectedNumber = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberPicker.dataSource = self
        numberPicker.delegate = self
        
        selectedNumber = baseNumber
    }
    
    
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 15
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selectedNumber = baseNumber+row*2
        return "\(selectedNumber)"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedNumber = baseNumber+row*2
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

