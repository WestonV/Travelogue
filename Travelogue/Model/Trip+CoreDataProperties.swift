//
//  Trip+CoreDataProperties.swift
//  Travelogue
//
//  Created by Weston Verhulst on 5/6/19.
//  Copyright © 2019 Weston Verhulst. All rights reserved.
//
//

import Foundation
import CoreData


extension Trip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trip> {
        return NSFetchRequest<Trip>(entityName: "Trip")
    }

    @NSManaged public var name: String?
    @NSManaged public var entry: NSSet?

}

// MARK: Generated accessors for entry
extension Trip {

    @objc(addEntryObject:)
    @NSManaged public func addToEntry(_ value: Entry)

    @objc(removeEntryObject:)
    @NSManaged public func removeFromEntry(_ value: Entry)

    @objc(addEntry:)
    @NSManaged public func addToEntry(_ values: NSSet)

    @objc(removeEntry:)
    @NSManaged public func removeFromEntry(_ values: NSSet)

}
