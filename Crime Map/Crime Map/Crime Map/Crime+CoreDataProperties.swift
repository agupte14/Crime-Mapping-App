//
//  Crime+CoreDataProperties.swift
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

extension Crime {

    @NSManaged var arrest: String?
    @NSManaged var block: String?
    @NSManaged var case_num: String?
    @NSManaged var domestic: String?
    @NSManaged var cases: Location?
    @NSManaged var crime_des: NSSet?

    func addCrimeDesc(crimeDes:CrimeDescription) {
        self.mutableSetValueForKey("crime_des").addObject(crimeDes)
    }
}
