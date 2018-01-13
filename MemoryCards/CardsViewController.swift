//
//  CardsViewController.swift
//  MemoryCards
//
//  Created by Admin on 09.01.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    @IBOutlet weak var cardsCollectionView: UICollectionView!
    @IBOutlet weak var flipsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var numberOfCards = Int()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardsCollectionView.delegate = self
        cardsCollectionView.dataSource = self
        
        runTimer()
    }
    
    @objc func updateTimer() {
        timeElapsed += 0.1
        timeLabel.text = "\(round(10*timeElapsed)/10)"
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    func showFinalSlert(flips: Int, time: String) {
        let alert = UIAlertController(title: "Congratulations!\nYour results are:", message: "Flips: \(flips)\nTime spent: \(time)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Back to main menu"), style: .`default`, handler: { _ in
            self.goBack()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension CardsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
                    UIView.transition(with: cell, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
                    UIView.transition(with: cell2, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
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
