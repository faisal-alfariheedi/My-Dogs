//
//  Dog+CoreDataProperties.swift
//  
//
//  Created by faisal on 04/05/1443 AH.
//
//

import Foundation
import CoreData


extension Dog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dog> {
        return NSFetchRequest<Dog>(entityName: "Dog")
    }

    @NSManaged public var name: String?
    @NSManaged public var color: String?
    @NSManaged public var food: String?
    @NSManaged public var img: Data?

}
