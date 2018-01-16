//
//  RecordObj+CoreDataProperties.swift
//  MemoryCards
//
//  Created by Admin on 14.01.18.
//  Copyright © 2018 Admin. All rights reserved.
//
//

import Foundation
import CoreData


extension RecordObj {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecordObj> {
        return NSFetchRequest<RecordObj>(entityName: "Record")
    }

    @NSManaged public var username: String?
    @NSManaged public var flips: Int32
    @NSManaged public var time: Double
    @NSManaged public var cardsNumber: Int32

}
