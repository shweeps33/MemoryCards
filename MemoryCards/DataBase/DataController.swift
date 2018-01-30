//
//  DataController.swift
//  MemoryCards
//
//  Created by Admin on 14.01.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import CoreData

class DataController: NSObject, NSFetchedResultsControllerDelegate{
    var managedObjectContext = NSManagedObjectContext()
    init(completionClosure: @escaping () -> ()) {
        let persistentContainer = NSPersistentContainer(name: "RecordsDataBase")
        persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
            completionClosure()
        }
    }
}
