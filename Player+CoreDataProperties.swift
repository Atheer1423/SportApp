//
//  Player+CoreDataProperties.swift
//  SportApp
//
//  Created by admin on 29/12/2021.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var name: String?
    @NSManaged public var sportItem: String?
    @NSManaged public var age: Int16
    @NSManaged public var hight: Int16

}

extension Player : Identifiable {

}
