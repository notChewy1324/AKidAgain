//
//  EnrollViewController.swift
//  MyKidAgain
//
//  Created by Chewy1324 on 9/23/18.
//  Copyright © 2018 Chewy1324. All rights reserved.
//

import UIKit
import Firebase
class EnrollViewController: UIViewController {

    @IBOutlet weak var Photos: UIWebView!
    @IBOutlet weak var titleText: UINavigationItem!
    
    @IBAction func RefreshButton(_ sender: Any) {
        setupRemoteConfigDefaults()
        fecthRemoteConfig()
        updateViewWithRCValues()
    }
    //remote-config
    func updateViewWithRCValues(){
        //remote config values here
        let SouthEvents = RemoteConfig.remoteConfig().configValue(forKey: "VolunteerEnroll").stringValue ?? ""
        let url = URL(string: "\(SouthEvents)")
        Photos.loadRequest(URLRequest(url: url!))
    }
    func setupRemoteConfigDefaults(){
        let defaultValues = [
            "VolunteerEnroll" : "https://akidagain.org/volunteer-form/" as NSObject
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
