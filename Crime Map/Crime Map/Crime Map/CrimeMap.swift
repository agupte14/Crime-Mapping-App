//
//  CrimeMap.swift
//  Crime Map
//
//  Created by Teddy on 7/4/16.
//  Copyright © 2016 Teddy. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import MapKit

class CrimeMap: UIViewController,MKMapViewDelegate {
//    var LocDat:Location? = nil
    var CrimeDat = [Crime]()
//    var CrimeDat:Crime?=nil
    var Loc:Location? = nil
    var mapCenter:CLLocationCoordinate2D? = nil
    @IBOutlet weak var layout: UISegmentedControl!
    @IBOutlet weak var map: MKMapView!
    
    @IBAction func mapLayout(sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            map.mapType = .Standard
        case 1:
            map.mapType = .Satellite
        default:
            map.mapType = .Hybrid
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.title = (LocDat?.area!)?.capitalizedString
        CenterMap()
        loadMap()
        
    }
    
    func CenterMap(){
        var lat:Double = 0.0
        var long:Double = 0.0
        for loc in CrimeDat{
            lat += (loc.cases?.latitude?.doubleValue)!
            long += (loc.cases?.longitude?.doubleValue)!
        }
        let lati = lat/Double(CrimeDat.count)
        let longi = long/Double(CrimeDat.count)
        mapCenter = CLLocationCoordinate2D(latitude: lati, longitude: longi)
    }
    

    
    var mapAnnotation: MKPointAnnotation?
    func DispMap() {
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: mapCenter!, span: span)
        for loc in CrimeDat{
        if let annotation = mapAnnotation {
            annotation.coordinate = mapCenter!
            annotation.title = loc.cases?.area
        } else {
            mapAnnotation = MKPointAnnotation()
            mapAnnotation!.coordinate = mapCenter!
            mapAnnotation!.title = loc.cases?.area
            map!.addAnnotation(mapAnnotation!)
        }
        
            map!.setRegion(region, animated: true)
        }
    }
    func loadMap() {
        let currentLoc = CLLocationCoordinate2D(latitude: 41.8349, longitude: -87.6270)
        let region = MKCoordinateRegionMakeWithDistance(currentLoc, 1000*2,1000*2)
        map!.setRegion(region, animated: true)
        DispMap()
        
    }

    
    
    
    
}