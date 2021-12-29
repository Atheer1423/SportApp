//
//  Sport+CoreDataProperties.swift
//  SportApp
//
//  Created by admin on 29/12/2021.
//
//

import Foundation
import CoreData


extension Sport {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sport> {
        return NSFetchRequest<Sport>(entityName: "Sport")
    }

    @NSManaged public var title: String?
    @NSManaged public var image: Data?

}

extension Sport : Identifiable {

}
