//
//  OpenSceneViewController.swift
//  A Kid Again
//
//  Created by Chewy1324 on 7/10/18.
//  Copyright © 2018 Chewy1324. All rights reserved.
//

import UIKit
import Firebase
class OpenSceneViewController: UIViewController {
    
    //remote-config
    func updateViewWithRCValues(){
        
        //remote config values here
        let SouthEvents = RemoteConfig.remoteConfig().configValue(forKey: "AppBlocker").stringValue ?? ""
        UserDefaults.standard.setValue(SouthEvents, forKey: "AppBlockerScreen")
    }
    
    func setupRemoteConfigDefaults(){
        let defaultValues = [
            "AppBlocker" : "false" as NSObject
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
        if UserDefaults.standard.bool(forKey: "AppBlockerScreen") == true {
            let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "AppBlocker") as! AppBlockerViewController
            self.navigationController?.pushViewController(homeVc, animated: false)
        }
        if UserDefaults.standard.bool(forKey: "AppBlockerScreen") == false {
            if UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN") == true {
                let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! HomeViewController
                self.navigationController?.pushViewController(homeVc, animated: false)
            }
            if UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN") == false {
                UserDefaults.standard.set(true, forKey: "Database")
            }
        }
    }

    @IBAction func Something(_ sender: Any) {
        ClickSound()
    }
}

