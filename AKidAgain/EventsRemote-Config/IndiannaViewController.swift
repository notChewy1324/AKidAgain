//
//  IndiannaViewController.swift
//  A Kid Again
//
//  Created by Chewy1324 on 6/20/18.
//  Copyright © 2018 Chewy1324. All rights reserved.
//

import UIKit
import Firebase

class IndiannaViewController: UIViewController {

    
    @IBOutlet weak var myEventsText: UITextView!
    

    //remote-config
    func updateViewWithRCValues(){
        //remote config values here
        let SouthEvents = RemoteConfig.remoteConfig().configValue(forKey: "IndiannaEventText").stringValue ?? ""
        myEventsText.text = (SouthEvents)
    }
    
    func setupRemoteConfigDefaults(){
        let defaultValues = [
            "IndiannaEventText" : "Events are coming soon!" as NSObject
        ]
        RemoteConfig.remoteConfig().setDefaults(defaultValues)
    }
    
    func fecthRemoteConfig(){
        //FIX DEVMODE before production
        let debugSettings = RemoteConfigSettings(developerModeEnabled: true)
        RemoteConfig.remoteConfig().configSettings = debugSettings
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: 0) { [unowned self] (status, error) in
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
