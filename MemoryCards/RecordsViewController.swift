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
        let departmentSort = NSSortDescriptor(key: "flips", ascending: true)
        let lastNameSort = NSSortDescriptor(key: "time", ascending: true)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Record")
        let filter = 11
        request.predicate = NSPredicate(format: "flips < \(filter)")
        request.sortDescriptors = [departmentSort, lastNameSort]
        
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        
        do {
            try fetchedResultsController.performFetch()
            print(fetchedResultsController.sections?.count)
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
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let results = fetchedResultsController.sections?[section].numberOfObjects ?? 0
        switch section {
        case 0 :
            if results > 5 {
                return 5
            } else {
                return results
            }
        case 1:
            if results > 5 {
                return 5
            } else {
                return results
            }
        case 2:
            if results > 5 {
                return 5
            } else {
                return results
            }
        case 3:
            if results > 5 {
                return 5
            } else {
                return results
            }
        default:
            if results > 5 {
                return 5
            } else {
                return results
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! RecordTableViewCell
        
        guard let sections = fetchedResultsController.sections else {
            fatalError("Sections missing")
        }
        
        let section = sections[indexPath.section]
        guard let itemsInSection = section.objects as? [RecordObj] else {
            fatalError("Items missing")
        }
        
        let record = itemsInSection[indexPath.row]
        let userID = Double(record.flips) * record.time.roundTo(to: 100) * 10
        let username = "\(record.username!).\(userID)"
        cell.userLabel.text = username
        cell.flipsLabel.text = String(record.flips)
        cell.timeLabel.text = String(record.time.roundTo(to: 100))
        
        return cell
    }
}
