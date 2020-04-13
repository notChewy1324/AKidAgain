//
//  IndianaChaptersViewController.swift
//  A Kid Again
//
//  Created by Chewy1324 on 9/6/18.
//  Copyright © 2018 Chewy1324. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCrashlytics
class IndianaChaptersViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    //remote-config
    func updateViewWithRCValues(){
        
        //remote config values here
        let eventName = RemoteConfig.remoteConfig().configValue(forKey: "IndianaChapterEvent").stringValue ?? ""
        label.text = (eventName)
    }
    
    func setupRemoteConfigDefaults(){
        let defaultValues = [
            "IndianaChapterEvent" : "Loading..." as NSObject
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
