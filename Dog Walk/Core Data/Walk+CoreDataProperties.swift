//
//  Walk+CoreDataProperties.swift
//  Dog Walk
//
//  Created by Pavel Ivanov on 9/6/19.
//  Copyright © 2019 Pavel Ivanov. All rights reserved.
//
//

import Foundation
import CoreData


extension Walk {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Walk> {
        return NSFetchRequest<Walk>(entityName: "Walk")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var dog: Dog?
}
