//
//  Entity+CoreDataProperties.swift
//  fluid
//
//  Created by Ziyad Khalil on 5/7/19.
//  Copyright © 2019 Ziyad Khalil. All rights reserved.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var type: String?
    @NSManaged public var date: Date?
    @NSManaged public var value: String?
    @NSManaged public var isTaskDone: Bool

}
