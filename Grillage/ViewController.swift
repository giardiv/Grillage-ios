//
//  ViewController.swift
//  Grillage
//
//  Created by Vincent on 23/06/2016.
//  Copyright © 2016 Vincent. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    var lat = 0.0
    var lon = 0.0
    var locationCount = 0
    
    let shareData = ShareData.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationCount = 0
        
        if(CLLocationManager.locationServicesEnabled()){
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        self.shareData.existNewPadlock = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manage: CLLocationManager, didUpdateLocations location: [CLLocation]){
        let location = location.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        //let testCenter = CLLocationCoordinate2D(latitude: 5.38967857137824, longitude: 45.9255129006188)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.0001, longitudeDelta: 0.0001))
        
        
        mapView.setRegion(region, animated: true)
        
        self.shareData.lat = location.coordinate.latitude
        self.shareData.lon = location.coordinate.longitude
        
        print(self.shareData.lat ," / ", self.shareData.lon)
        
        if(locationCount <= 5){
            locationCount += 1
        }
        if(locationCount == 5){
            self.getPadlockNearMe()
        }
    }
    
    func getPadlockNearMe(){
        let loc = ["lon": self.shareData.lon,"lat": self.shareData.lat]
        print("getting padlock...")
        Alamofire.request(.GET, "http://giardi.fr/grillage/web/app_dev.php/padlocks",parameters: ["loc": loc])
            .responseString { response in
                let data = response.result.value as String?
                if let dataFromString = data?                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 .dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false){
                    let json = JSON(data: dataFromString)
                    //newUserName = json["data"].stringValue
                    
                    print(json["data"])
                    if(json["ok"]){
                        for padlock in json["data"]{
                            self.addMark(padlock.1)
                        }
                    }
            }
        }
    }

    func addMark(padlock: JSON){
        let coord = CLLocationCoordinate2D(latitude: padlock["lat"].doubleValue, longitude: padlock["lon"].doubleValue)
        let date = NSDate(timeIntervalSince1970: padlock["date"].doubleValue)

        let dayTimePeriodFormatter = NSDateFormatter()
        dayTimePeriodFormatter.dateFormat = "EEE d, MMM y"
        
        let dateString = dayTimePeriodFormatter.stringFromDate(date)
        
        let ano = MapPin(coordinate: coord, title: dateString, subtitle: padlock["text"].stringValue)
        mapView.addAnnotations([ano])
    }
}

