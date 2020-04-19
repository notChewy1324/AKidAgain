//
//  HomeViewController.swift
//  A Kid Again
//
//  Created by Chewy1324 on 7/10/18.
//  Copyright © 2018 Chewy1324. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleMobileAds
import FirebaseCrashlytics
class HomeViewController: UIViewController, GADInterstitialDelegate {
    
    let email = UserDefaults.standard.string(forKey: "UserEmail")
    let password = UserDefaults.standard.string(forKey: "UserPassword")
    let intro = UserDefaults.standard.bool(forKey: "Intro_App")
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: -FIX ME
        //Real Ads: ca-app-pub-4600989320659230/6809684574
        //Test Ads: ca-app-pub-3940256099942544/4411468910
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-4600989320659230/6809684574")
        let request = GADRequest()
        interstitial.load(request)
        
        if (intro == true) {
            let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "Welcome") as! WelcomeViewController
            self.navigationController?.pushViewController(homeVc, animated: false)
        } else {
            Auth.auth().signIn(withEmail: email!, password: password!) { (user, error) in
                if let error = error {
                    Crashlytics.crashlytics().record(error: error)
                }
                if user != nil {
                    //They are in :)
                    userHelper_Tool()
                    if self.interstitial.isReady {
                        self.interstitial.present(fromRootViewController: self)
                    }
                } else {
                    //Log them out
                   if self.interstitial.isReady {
                       self.interstitial.present(fromRootViewController: self)
                   }
                    UserDefaults.standard.set(false, forKey: "ISUSERLOGGEDIN")
                    let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "OpenScene") as! OpenSceneViewController
                    self.navigationController?.pushViewController(homeVc, animated: false)
                    
                    //Alert Function
                    let defaultAction = UIAlertAction(title: "OK",
                                         style: .default) { (action) in
                    }
                    
                    let alert = UIAlertController(title: "Error 401",
                          message: "There was a problem connecting you to our servers. Please try again.",
                          preferredStyle: .alert)
                    alert.addAction(defaultAction)
                     
                    self.present(alert, animated: true) {
                        // The alert was presented
                    }
                }
            }
        }
    }
    
    @IBAction func doSomething(_ sender: AnyObject) {
        ClickSound()
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        }
    }
}
