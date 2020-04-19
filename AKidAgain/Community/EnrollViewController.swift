//
//  EnrollViewController.swift
//  MyKidAgain
//
//  Created by Chewy1324 on 9/23/18.
//  Copyright © 2018 Chewy1324. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds
import FirebaseCrashlytics
class EnrollViewController: UIViewController, GADInterstitialDelegate {

    @IBOutlet weak var Photos: UIWebView!
    @IBOutlet weak var titleText: UINavigationItem!
    var interstitial: GADInterstitial!
    
    @IBAction func RefreshButton(_ sender: Any) {
        
        //MARK: -FIX ME
        //Real Ads: ca-app-pub-4600989320659230/6809684574
        //Test Ads: ca-app-pub-3940256099942544/4411468910
        self.interstitial = GADInterstitial(adUnitID: "ca-app-pub-4600989320659230/6809684574")
        self.interstitial.delegate = self
        
        let request = GADRequest()
        self.interstitial.load(request)
        
        setupRemoteConfigDefaults()
        fecthRemoteConfig()
        updateViewWithRCValues()
        
        if self.interstitial.isReady {
            self.interstitial.present(fromRootViewController: self)
        } else {
          //Do nothin
        }

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
        
        //MARK: -FIX ME
        //Real Ads: ca-app-pub-4600989320659230/6809684574
        //Test Ads: ca-app-pub-3940256099942544/4411468910
        self.interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        self.interstitial.delegate = self
        
        let request = GADRequest()
        self.interstitial.load(request)
        
        setupRemoteConfigDefaults()
        fecthRemoteConfig()
        updateViewWithRCValues()
        
        if self.interstitial.isReady {
            self.interstitial.present(fromRootViewController: self)
        } else {
          //Do nothin
        }
        
    }
}
