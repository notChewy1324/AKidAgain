//
//  MapVerifyViewController.swift
//  A Kid Again
//
//  Created by Chewy1324 on 6/21/18.
//  Copyright © 2018 Chewy1324. All rights reserved.
//

import UIKit
import Firebase

class MapVerifyViewController: UIViewController {

    @IBOutlet weak var DisplayText: UILabel!
    @IBOutlet weak var myEventsText: UIButton!
    @IBOutlet weak var BACK: UIButton!
    
    
    //remote-config
    func updateViewWithRCValues(){
        //remote config values here
        let SouthEvents = RemoteConfig.remoteConfig().configValue(forKey: "ContinueButtonText").stringValue ?? ""
        myEventsText.setTitle(SouthEvents, for: .normal)
        
        let Events = RemoteConfig.remoteConfig().configValue(forKey: "UserText").stringValue ?? ""
        DisplayText.text = (Events)
        
        let South = RemoteConfig.remoteConfig().configValue(forKey: "BackButtonText").stringValue ?? ""
        BACK.setTitle(South, for: .normal)
    }
    
    func setupRemoteConfigDefaults(){
        let defaultValues = [
            "ContinueButtonText" : "Continue" as NSObject,
            "UserText" : "Make sure that you are connected to Wi-Fi. Please allow for location to use the Community-Map." as NSObject,
            "BackButtonText" : "  " as NSObject
        ]
        RemoteConfig.remoteConfig().setDefaults(defaultValues)
    }
    
    func fecthRemoteConfig(){
        //FIX DEVMODE before production
        let debugSettings = RemoteConfigSettings(developerModeEnabled: true)
        RemoteConfig.remoteConfig().configSettings = debugSettings
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: 604800) { [unowned self] (status, error) in
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
        setupRemoteConfigDefaults()
        fecthRemoteConfig()
        updateViewWithRCValues()
    }

}
