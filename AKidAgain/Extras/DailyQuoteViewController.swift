//
//  DailyQuoteViewController.swift
//  A Kid Again
//
//  Created by Chewy1324 on 6/15/18.
//  Copyright © 2018 Chewy1324. All rights reserved.
//

import UIKit
import Firebase
class DailyQuoteViewController: UIViewController {

    @IBOutlet weak var DailyQuoteText: UILabel!
    @IBOutlet weak var myEventsText: UILabel!
    
    @IBAction func doSomething(_ sender: AnyObject) {
        ClickSound()
    }
    
    //remote-config
    func updateViewWithRCValues(){
        
        //remote config values here
        let SouthEvents = RemoteConfig.remoteConfig().configValue(forKey: "DailyQuoteText").stringValue ?? ""
        myEventsText.text = (SouthEvents)
        
        
        let Bottom = RemoteConfig.remoteConfig().configValue(forKey: "DailyQuoteTitleText").stringValue ?? ""
        DailyQuoteText.text = (Bottom)
    }

    func setupRemoteConfigDefaults(){
        let defaultValues = [
            "DailyQuoteText" : "Loading..." as NSObject,
            "DailyQuoteTitleText" : "Quote" as NSObject
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
