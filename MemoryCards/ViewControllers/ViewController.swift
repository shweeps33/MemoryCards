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
    
    var selectedNumber = Int()
    let pickerColors = [UIColor(red:0.39, green:0.93, blue:0.20, alpha:1.0), UIColor(red:0.80, green:0.85, blue:0.20, alpha:1.0), UIColor(red:0.85, green:0.67, blue:0.20, alpha:1.0), UIColor(red:0.85, green:0.39, blue:0.20, alpha:1.0)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberPicker.dataSource = self
        numberPicker.delegate = self
        selectedNumber = levelNumbers[0]
    }
    
    
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return levelNumbers.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedNumber = levelNumbers[row]
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let myTitle = levelNames[row] + "(\(levelNumbers[row]) cards)"
        pickerLabel.backgroundColor = pickerColors[row]
        pickerLabel.text = myTitle
        pickerLabel.textAlignment = .center
        return pickerLabel
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 180
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
}

