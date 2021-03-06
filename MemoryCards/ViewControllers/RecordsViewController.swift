//
//  RecordsViewController.swift
//  MemoryCards
//
//  Created by Admin on 14.01.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import CoreData

class RecordsViewController: UIViewController, NSFetchedResultsControllerDelegate {

    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeFetchedResultsController()
    }
    func initializeFetchedResultsController() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Record")
        let cardsNumberSort = NSSortDescriptor(key: "cardsNumber", ascending: true)
        let timeSort = NSSortDescriptor(key: "time", ascending: true)
        request.sortDescriptors = [cardsNumberSort, timeSort]
        request.predicate = NSPredicate(format: "cardsNumber IN %@", levelNumbers)
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: "cardsNumber", cacheName: nil)
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
}

extension RecordsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if (fetchedResultsController.sections?.count)! > levelNames.count {
            return levelNames.count
        } else {
            return (fetchedResultsController.sections?.count)!
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections![section].numberOfObjects
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! RecordTableViewCell
        //let indexPt = IndexPath(row: indexPath.row, section: levelNames[indexPath.section].1)
        let record = fetchedResultsController.object(at: indexPath) as! RecordObj
            cell.userLabel.text = record.username
            cell.flipsLabel.text = String(record.flips)
            cell.timeLabel.text = String(record.time.round(to: 100))
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(levelNumbers[section]) cards"
    }
}
