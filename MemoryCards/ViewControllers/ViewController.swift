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
        numberPicker.selectedRow(inComponent: 0)
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
    
    let pickerColors = [UIColor(red:0.39, green:0.93, blue:0.20, alpha:1.0), UIColor(red:0.80, green:0.85, blue:0.20, alpha:1.0), UIColor(red:0.85, green:0.67, blue:0.20, alpha:1.0), UIColor(red:0.85, green:0.39, blue:0.20, alpha:1.0)]
    
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
        return 4
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedNumber = baseNumber+row*4
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let myTitle = levelNames[row].0 + "(\(levelNames[row].1) cards)"
        pickerLabel.backgroundColor = pickerColors[row]
        pickerLabel.text = myTitle
        pickerLabel.textAlignment = .center
        return pickerLabel
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 180
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
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

