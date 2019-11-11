//
//  TodayViewController.swift
//  Quote
//
//  Created by Chewy1324 on 3/27/19.
//  Copyright © 2019 Chewy1324. All rights reserved.
//

import UIKit
import NotificationCenter
import Firebase
class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseApp.configure()
        setupRemoteConfigDefaults()
        fecthRemoteConfig()
        updateViewWithRCValues()
    }

    //remote-config
    func updateViewWithRCValues(){
        
        //remote config values here
        let SouthEvents = RemoteConfig.remoteConfig().configValue(forKey: "DailyQuoteText").stringValue ?? ""
        Label.text = (SouthEvents)
    }
    
    func setupRemoteConfigDefaults(){
        let defaultValues = [
            "DailyQuoteText" : "“The first step toward success is taken when you refuse to be a captive of the environment in which you first find yourself.” – Mark Caine" as NSObject
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

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        FirebaseApp.configure()
        setupRemoteConfigDefaults()
        fecthRemoteConfig()
        updateViewWithRCValues()
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        completionHandler(NCUpdateResult.newData)
    }
    
}
