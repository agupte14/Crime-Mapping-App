//
//  Location+CoreDataProperties.swift
//  Crime Map
//
//  Created by Teddy on 7/4/16.
//  Copyright © 2016 Teddy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Location {

    @NSManaged var area: String?
    @NSManaged var latitude: NSNumber?
    @NSManaged var location_des: String?
    @NSManaged var longitude: NSNumber?
    @NSManaged var block: NSSet?
    
    func addBlock(block: Crime) {
        self.mutableSetValueForKey("block").addObject(block)
    }

}
