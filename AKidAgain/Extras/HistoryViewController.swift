//
//  HistoryViewController.swift
//  A Kid Again
//
//  Created by Chewy1324 on 4/28/19.
//  Copyright © 2019 Chewy1324. All rights reserved.
//

import UIKit
import Firebase
class HistoryViewController: UIViewController {

    @IBOutlet weak var history: UIWebView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    //remote-config
    func updateViewWithRCValues(){
        //remote config values here
        let SouthEvents = RemoteConfig.remoteConfig().configValue(forKey: "HistoryVideoView").stringValue ?? ""
        let url = URL(string: "\(SouthEvents)")
        history.loadRequest(URLRequest(url: url!))
        if history.isLoading == true {
            loader.startAnimating()
            loader.isHidden = false
        }
        if history.isLoading == false {
            loader.stopAnimating()
            loader.isHidden = true
        }

    }
    func setupRemoteConfigDefaults(){
        let defaultValues = [
            "HistoryVideoView" : "https://www.youtube.com/embed/XALm-l-68-I" as NSObject
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

    @IBAction func button(_ sender: Any) {
        ClickSound()
    }
}
