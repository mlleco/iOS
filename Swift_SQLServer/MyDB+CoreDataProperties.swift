//
//  MyDB+CoreDataProperties.swift
//  swiftSql
//
//  Created by NSR on 2023-07-10.
//
//

import Foundation
import CoreData


extension MyDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyDB> {
        return NSFetchRequest<MyDB>(entityName: "MyDB")
    }

    @NSManaged public var id: Int32
    @NSManaged public var key: String?

}

extension MyDB : Identifiable {

}
