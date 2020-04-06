//
//  VideoViewController.swift
//  A Kid Again
//
//  Created by Chewy1324 on 6/30/18.
//  Copyright © 2018 Chewy1324. All rights reserved.
//

import UIKit
import Firebase
class VideoViewController: UIViewController {
    
    @IBOutlet weak var History: UIWebView!
    @IBOutlet weak var titleText: UINavigationItem!
    
    func Top(TopCode:String){
        let url = URL(string: "https://www.youtube.com/embed/\(TopCode)")
        History.loadRequest(URLRequest(url: url!))
    }
    
    //remote-config
    func updateViewWithRCValues() {
        //remote config values here
        let SouthEvents = RemoteConfig.remoteConfig().configValue(forKey: "TopVideoCode").stringValue ?? ""
        Top(TopCode: "\(SouthEvents)")
    }
    
    func setupRemoteConfigDefaults() {
        let defaultValues = [
            "TopVideoCode" : "bkTTG-QRsBw" as NSObject
        ]
        RemoteConfig.remoteConfig().setDefaults(defaultValues)
    }
    
    func fecthRemoteConfig() {
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
    
    @IBAction func doSomething(_ sender: AnyObject) {
        History.reload()
    }
}
