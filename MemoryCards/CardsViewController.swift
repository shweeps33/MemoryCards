//
//  CardsViewController.swift
//  MemoryCards
//
//  Created by Admin on 09.01.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import CoreData

class CardsViewController: UIViewController {
    @IBOutlet weak var cardsCollectionView: UICollectionView!
    @IBOutlet weak var flipsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var numberOfCards = Int()
    var nuuumber = 0
    var arrayOfNumbers = [Int]()
    var flipsCounter = 0 {
        didSet {
            flipsLabel.text = "Flips: \(flipsCounter)"
        }
    }
    var timer : Timer? = nil
    var timeElapsed = 0.0
    var prevCardInfo = (index: -1, number: -1)
    var firstCardSelected = false
    let color = ["red" : UIColor(red:1.00, green:0.12, blue:0.00, alpha:0.5), "green" : UIColor(red:0.80, green:1.00, blue:0.00, alpha:0.5)]
    var alert = UIAlertController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardsCollectionView.delegate = self
        cardsCollectionView.dataSource = self
        nuuumber = numberOfCards
        runTimer()
    }
    
    @objc func updateTimer() {
        timeElapsed += 0.1
        timeLabel.text = "\(timeElapsed.roundTo(to: 10))"
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    func showFinalSlert(flips: Int, time: String) {
        alert = UIAlertController(title: "Congratulations!\nYour results are:", message: "Flips: \(flips)\nTime spent: \(time)\nType your name and OK to save results to Records Table", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
            textField.placeholder = "Name (min 3 symbols)"
            textField.delegate = self
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
            print("Canelled")
        })
        alert.addAction(cancelAction)
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: "Back to main menu"), style: .`default`, handler: { _ in
            self.goBack()
        })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    func goBack() {
        saveRecord(username: alert.textFields![0].text!, flips: flipsCounter, time: timeElapsed, numberOfCards: nuuumber)
        navigationController?.popViewController(animated: true)
    }
    
    func saveRecord(username: String, flips: Int, time: Double, numberOfCards: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Record", in: context)
        let newRecord = NSManagedObject(entity: entity!, insertInto: context)
        let flipsNSNumber = NSNumber(value: flips)
        newRecord.setValue(username, forKey: "username")
        newRecord.setValue(flipsNSNumber, forKey: "flips")
        newRecord.setValue(time, forKey: "time")
        newRecord.setValue(numberOfCards, forKey: "cardsNumber")
        appDelegate.saveContext()
    }
}

extension CardsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        if (newLength > 2) {
            self.alert.actions[1].isEnabled = true
        }else{
            self.alert.actions[1].isEnabled = false
        }
        return true
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCards
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CollectionViewCell
        cell.labelForNumber.text = String(arrayOfNumbers[indexPath.item])
        cell.isFlipped = false
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        
        cell.isFlipped = true
        if !firstCardSelected {
            UIView.transition(with: cell, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            flipsCounter += 1
            firstCardSelected = true
            prevCardInfo.index = indexPath.item
            prevCardInfo.number = Int(cell.labelForNumber.text!)!
        }
        else if (indexPath.item != prevCardInfo.index) {
            UIView.transition(with: cell, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            flipsCounter += 1
            let number = Int(cell.labelForNumber.text!)
            let cell2 = collectionView.cellForItem(at: IndexPath(row: self.prevCardInfo.index, section: 0)) as! CollectionViewCell
            
            if number == prevCardInfo.number {
                cell.backgroundColor = color["green"]
                cell2.backgroundColor = color["green"]
                UIView.animate(withDuration: 1.0, animations: {
                        cell.alpha = 0
                        cell2.alpha = 0
                    }){ _ in
                        cell.removeFromSuperview()
                        cell2.removeFromSuperview()
                    }
                    self.numberOfCards -= 2
                    if self.numberOfCards == 0 {
                        self.timer?.invalidate()
                        DispatchQueue.main.async {
                            self.showFinalSlert(flips: self.flipsCounter, time: self.timeLabel.text!)
                        }
                    }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    UIView.transition(with: cell, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
                    UIView.transition(with: cell2, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
                    cell.isFlipped = false
                    cell2.isFlipped = false
                })
            }
            firstCardSelected = false
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if numberOfCards <= 12 {
            return CGSize.init(width: self.view.frame.width/3-16, height: self.view.frame.width/3-16)
        }
        else if numberOfCards <= 24 {
            return CGSize.init(width: self.view.frame.width/4-14, height: self.view.frame.width/4-14)
        }
        else {
            return CGSize.init(width: self.view.frame.width/5-12, height: self.view.frame.width/5-12)
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
