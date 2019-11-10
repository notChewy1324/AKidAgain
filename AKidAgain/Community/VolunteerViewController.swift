//
//  VolunteerViewController.swift
//  MyKidAgain
//
//  Created by Chewy1324 on 9/23/18.
//  Copyright © 2018 Chewy1324. All rights reserved.
//

import UIKit
import Firebase
class VolunteerViewController: UIViewController {

    @IBOutlet weak var Photos: UIWebView!
    @IBOutlet weak var text: UITextView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    
    @IBAction func doSomething(_ sender: AnyObject) {
        ClickSound()
    }
    
    //remote-config
    func updateViewWithRCValues(){
        //remote config values here
        let SouthEvents = RemoteConfig.remoteConfig().configValue(forKey: "VolunteerPic").stringValue ?? ""
        let url = URL(string: "\(SouthEvents)")
        Photos.loadRequest(URLRequest(url: url!))
        if Photos.isLoading == true {
            loader.startAnimating()
            loader.isHidden = false
        }
        if Photos.isLoading == false {
            loader.stopAnimating()
            loader.isHidden = true
        }
    }
    func setupRemoteConfigDefaults(){
        let defaultValues = [
            "VolunteerPic" : "https://akidagain.org/wp-content/uploads/2017/02/AKA-Volunteer-Header-Image_2-1904x600.jpg" as NSObject
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
