//
//  AppBlockerViewController.swift
//  A Kid Again
//
//  Created by Chewy1324 on 5/30/19.
//  Copyright © 2019 Chewy1324. All rights reserved.
//

import UIKit
import Firebase
class AppBlockerViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    //remote-config
    func updateViewWithRCValues(){
        
        //remote config values here
        let SouthEvents = RemoteConfig.remoteConfig().configValue(forKey: "AppBlockerText").stringValue ?? ""
        label.text = (SouthEvents)
    }
    
    func setupRemoteConfigDefaults(){
        let defaultValues = [
            "AppBlockerText" : "Loading..." as NSObject
        ]
        RemoteConfig.remoteConfig().setDefaults(defaultValues)
    }
    
    func fecthRemoteConfig(){
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: 3600) { [unowned self] (status, error) in
            guard error == nil else {
                print("Uh-Oh. Got an error fetching remote values: \(String(describing: error))")
                return
            }
            print("Recived values from the cloud!")
            RemoteConfig.remoteConfig().fetchAndActivate()
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
