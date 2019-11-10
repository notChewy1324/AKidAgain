//
//  MapViewController.swift
//  A Kid Again
//
//  Created by Chewy1324 on 6/5/18.
//  Copyright © 2018 Chewy1324. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

class MapViewController: UIViewController, CLLocationManagerDelegate {

    //map
    @IBOutlet weak var MAP: MKMapView!
    
    
    let locationManager = CLLocationManager()
    
    
    //remote-config
    func updateViewWithRCValues(){
        //remote config values here
        let lat = RemoteConfig.remoteConfig().configValue(forKey: "MapAnnotationLatLocation").numberValue
        let long = RemoteConfig.remoteConfig().configValue(forKey: "MapAnnotationLongLocation").numberValue
        let title = RemoteConfig.remoteConfig().configValue(forKey: "MapAnnotationTitle").stringValue ?? ""
        let subtitle = RemoteConfig.remoteConfig().configValue(forKey: "MapAnnotationSubTitle").stringValue ?? ""
        
        //MAP location
        let span:MKCoordinateSpan = MKCoordinateSpan.init(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat as! CLLocationDegrees, long as! CLLocationDegrees)
        let _:MKCoordinateRegion = MKCoordinateRegion.init(center: location, span: span)
        let annotation = MKPointAnnotation()
        
        //annotation
        annotation.coordinate = location
        annotation.title = title
        annotation.subtitle = subtitle
        MAP.addAnnotation(annotation)
    }

    func setupRemoteConfigDefaults(){
        let defaultValues = [
            "MapAnnotationLatLocation" : 40.115725 as NSObject,
            "MapAnnotationLongLocation" : -82.997308 as NSObject,
            "MapAnnotationTitle" : "A Kid Again" as NSObject,
            "MapAnnotationSubTitle" : "Ohio Chapter" as NSObject
        ]
        RemoteConfig.remoteConfig().setDefaults(defaultValues)
    }

    func fecthRemoteConfig(){
        //FIX DEVMODE before production
        let debugSettings = RemoteConfigSettings(developerModeEnabled: true)
        RemoteConfig.remoteConfig().configSettings = debugSettings
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: 86400) { [unowned self] (status, error) in
            guard error == nil else {
                print("Uh-Oh. Got an error fetching remote values: \(String(describing: error))")
                return
            }
            print("Recived values from the cloud!")
            RemoteConfig.remoteConfig().activateFetched()
            self.updateViewWithRCValues()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //Map
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //Remote-Config
        setupRemoteConfigDefaults()
        fecthRemoteConfig()
        updateViewWithRCValues()

    }

    
    
    /*User Location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        
        let center = location.coordinate
        
        let span = MKCoordinateSpan(latitudeDelta: 0.10, longitudeDelta: 0.10)
        
        
        let region = MKCoordinateRegion(center: center, span: span)
        MAP.setRegion(region, animated: true)
        
        
        MAP.showsUserLocation = true
            
    }
 */
}
