//
//  Entry+CoreDataProperties.swift
//  Travelogue
//
//  Created by Weston Verhulst on 5/6/19.
//  Copyright © 2019 Weston Verhulst. All rights reserved.
//
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var image: NSData?
    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var trip: Trip?

}
