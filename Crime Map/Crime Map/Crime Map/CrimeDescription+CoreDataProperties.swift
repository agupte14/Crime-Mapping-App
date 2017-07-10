//
//  CrimeDescription+CoreDataProperties.swift
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

extension CrimeDescription {

    @NSManaged var primary: String?
    @NSManaged var secondary: String?
    @NSManaged var crime: Crime?
    
    

}
