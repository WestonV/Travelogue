//
//  Trip+CoreDataClass.swift
//  Travelogue
//
//  Created by Weston Verhulst on 5/6/19.
//  Copyright © 2019 Weston Verhulst. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Trip)
public class Trip: NSManagedObject {
    convenience init?(name: String?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let managedContext = appDelegate?.persistentContainer.viewContext,
            let name = name, name != "" else {
                return nil
        }
        self.init(entity: Trip.entity(), insertInto: managedContext)
        self.name = name
    }
}
