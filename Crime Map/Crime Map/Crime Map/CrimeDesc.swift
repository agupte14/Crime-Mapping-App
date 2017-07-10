//
//  CrimeDesc.swift
//  Crime Map
//
//  Created by Teddy on 7/4/16.
//  Copyright © 2016 Teddy. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class CrimeDesc: UITableViewController{
    var CriDat:Crime? = nil
    var CrDesArray = [CrimeDescription]()
//    var CrArray = [Crime]()
    override func viewDidLoad() {
        loadDat("primary", order: true)
    }
    //MARK: Table View
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return CrDesArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TabDes", forIndexPath: indexPath) as! CustomCell
        cell.label1.text = "Primary Description: \(CrDesArray[indexPath.row].primary!)"
        cell.label2.text = "\(CrDesArray[indexPath.row].secondary!)"
        return cell
    }
    
    func loadDat(type: String, order: Bool) {
        let sortOrder = NSSortDescriptor(key: type, ascending: order)
        CrDesArray = (CriDat!.crime_des?.sortedArrayUsingDescriptors([sortOrder])) as! [CrimeDescription]
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}