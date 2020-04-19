//
//  PhotosViewController.swift
//  A Kid Again
//
//  Created by Chewy1324 on 6/30/18.
//  Copyright © 2018 Chewy1324. All rights reserved.
//

import UIKit
import GoogleMobileAds
import FirebaseCrashlytics

class PhotosViewController: UIViewController, GADInterstitialDelegate {

    @IBOutlet weak var titleText: UINavigationItem!
    @IBOutlet weak var Photos: UIWebView!
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: -FIX ME
        //Real Ads: ca-app-pub-4600989320659230/6809684574
        //Test Ads: ca-app-pub-3940256099942544/4411468910
        self.interstitial = GADInterstitial(adUnitID: "ca-app-pub-4600989320659230/6809684574")
        self.interstitial.delegate = self
        
        let request = GADRequest()
        self.interstitial.load(request)
        
        let url = URL(string: "https://akidagain.smugmug.com/")
        Photos.loadRequest(URLRequest(url: url!))
        
        if self.interstitial.isReady {
            self.interstitial.present(fromRootViewController: self)
        } else {
          //Do nothin
        }
        
    }
    
    @IBAction func doSomething(_ sender: AnyObject) {
        Photos.reload()
    }
    
}
