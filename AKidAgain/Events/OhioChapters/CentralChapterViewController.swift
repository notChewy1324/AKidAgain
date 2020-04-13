//
//  CentralChapterViewController.swift
//  AKidAgain
//
//  Created by Cameron Garrison on 4/13/20.
//  Copyright © 2020 NotChewy1324. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCrashlytics
class CentralChapterViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    //remote-config
    func updateViewWithRCValues(){
        
        //remote config values here
        let eventName = RemoteConfig.remoteConfig().configValue(forKey: "CentralOhioChapterEvent").stringValue ?? ""
        label.text = (eventName)
    }
    
    func setupRemoteConfigDefaults(){
        let defaultValues = [
            "CentralOhioChapterEvent" : "Loading..." as NSObject
        ]
        RemoteConfig.remoteConfig().setDefaults(defaultValues)
    }
    
    func fecthRemoteConfig(){
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: 3600) { [unowned self] (status, error) in
            guard error == nil else {
                Crashlytics.crashlytics().record(error: error!)
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
    
    @IBAction func doSomething(_ sender: AnyObject) {
        ClickSound()
    }

}
