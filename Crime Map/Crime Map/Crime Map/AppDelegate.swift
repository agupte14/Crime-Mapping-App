//
//  AppDelegate.swift
//  Crime Map
//
//  Created by Teddy on 7/4/16.
//  Copyright © 2016 Teddy. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    
    func checkCD(){
        let fetchRequest = NSFetchRequest(entityName: "Location")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "area", ascending: true)]
        do {
            let results = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Location]
            for dept in results {
                print("\n********** \(dept.area!) ************")
//                print("\(dept.block!)")
                for emp in dept.block!{
                    if let emp = emp as? Crime {
//                    let emp = emp as? Crime
                        for vac in emp.crime_des!{
                            if let vac = vac as? CrimeDescription{
                            print("\(emp.case_num!) is a case of \(vac.primary!)  at \(emp.block!) with latitude \(dept.latitude) and longitude \(dept.longitude)")
                            }
                        }
                       
                        
                    }
                }
            }
        } catch {
            abort()
        }

    }
    
    func initCD(){
        let path = NSBundle.mainBundle().pathForResource("Crimes_-_Map", ofType: "csv")
        do {
            let file = try String(contentsOfFile: path!)
            let lines = NSString(string: file).componentsSeparatedByString("\n")
            var Locations = [String:Location]()
            var Crimes = [String:Crime]()
            var CrimeDes = [String:CrimeDescription]()
            let CrimeEntity = NSEntityDescription.entityForName("Crime", inManagedObjectContext: self.managedObjectContext)
            let CrDesEntity = NSEntityDescription.entityForName("CrimeDescription", inManagedObjectContext: self.managedObjectContext)
            let LocEntity = NSEntityDescription.entityForName("Location", inManagedObjectContext: self.managedObjectContext)
            var length = 0
            var bag = 0
            var bat = 0
            for line in lines {
                let cols = line.componentsSeparatedByString(",")
                length = cols.count
                if bag == 0{
                    bag = 1
                    bat = length
                }
                Length: if length < bat {
                    break Length
                }else {
                let case_num       = cols[0]
                let block   = cols[1]
                let primary = cols[2]
                let secondary = cols[3]
                let locDes = cols[4]
                let arrest = cols[5]
                let domestic = cols[6]
                let latitude = cols[7]
                let longitude = cols[8]
//                print(longitude)
//                let locapp = "\(latitude)"+"\(longitude)"
                if Locations[block] == nil {
                    let loc = Location(entity: LocEntity!, insertIntoManagedObjectContext: self.managedObjectContext)
                    loc.latitude = NSNumberFormatter().numberFromString(latitude)
                    loc.longitude = NSNumberFormatter().numberFromString(longitude.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()))
                   //print("\(loc.longitude)")
                    loc.location_des = locDes
                    loc.area = block
                    Locations[block] = loc
                    
                }
                let crAppend = "\(primary)"+"\(secondary)"
                if CrimeDes[crAppend] == nil{
                let crDES = CrimeDescription(entity: CrDesEntity!, insertIntoManagedObjectContext: self.managedObjectContext)
                crDES.primary = primary
                crDES.secondary = secondary
                    CrimeDes[block] = crDES
                
                }
                if Crimes[case_num]==nil{
                let cr = Crime(entity: CrimeEntity!, insertIntoManagedObjectContext: self.managedObjectContext)
                cr.arrest = arrest
                cr.domestic = domestic
                cr.block = block
                cr.case_num = case_num
                    Crimes[block] = cr
                    
                }
                Locations[block]?.addBlock(Crimes[block]!)
                Crimes[block]?.addCrimeDesc(CrimeDes[block]!)
            }
            self.saveContext()
            }
        } catch {
            abort()
        }

    }
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
//        initCD()
        if entityIsEmpty("Location"){
            initCD()
        }
//       checkCD()
        let controller = self.window?.rootViewController as! UINavigationController
        let master = controller.topViewController as! ViewController
        master.MOCObject = self.managedObjectContext
        return true
    }
    func entityIsEmpty(entity: String)->Bool{
        let fetch = NSFetchRequest(entityName: entity)
        do{
            let results = try self.managedObjectContext.executeFetchRequest(fetch) as! [NSManagedObject]
            if results.count == 0{
                return true
            }else {
                return false
            }
        }catch{
            abort()
        }
}
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.iit.sum16.Crime_Map" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("Crime_Map", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

}

