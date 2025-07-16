//
//  ToDoListItem+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by MinhHieu on 14/01/2025.
//
//

import Foundation
import CoreData


extension ToDoListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListItem> {
        return NSFetchRequest<ToDoListItem>(entityName: "ToDoListItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var createAt: Date?

}

extension ToDoListItem : Identifiable {

}
