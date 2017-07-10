//
//  CrimeData.swift
//  Crime Map
//
//  Created by Teddy on 7/4/16.
//  Copyright © 2016 Teddy. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class CrimeData:UITableViewController{
    var srcObj: Location? = nil
    var CrimesArray = [Crime]()
    
   

    override func viewDidLoad() {
        loadDat("case_num", order: true)
        tableView.reloadData()
    }

    //MARK: Segues
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MapView"{
            let controller = segue.destinationViewController as! CrimeMap

                controller.CrimeDat = CrimesArray

            
        }else if segue.identifier == "CrimeDes"{
            let controll = segue.destinationViewController as! CrimeDesc
            if let indexPath = tableView.indexPathForSelectedRow{
                controll.CriDat = CrimesArray[indexPath.row]
            }
        }
    }
    

    //MARK: Table View
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return CrimesArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TabCell", forIndexPath: indexPath) 
        cell.textLabel?.text = "Case #: \(CrimesArray[indexPath.row].case_num!)"
        return cell
    }
    
    func loadDat(type: String, order: Bool) {
        let sortOrder = NSSortDescriptor(key: type, ascending: order)
        CrimesArray = (srcObj!.block?.sortedArrayUsingDescriptors([sortOrder])) as! [Crime]

    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}