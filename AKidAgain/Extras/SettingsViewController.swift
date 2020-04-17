//
//  SettingsViewController.swift
//  A Kid Again
//
//  Created by Chewy1324 on 6/21/18.
//  Copyright © 2018 Chewy1324. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCrashlytics
import GoogleMobileAds
class SettingsViewController: UIViewController, GADInterstitialDelegate {

    //Objects
    @IBOutlet weak var label: UILabel!
    var interstitial: GADInterstitial!
    
    @IBAction func LogOut(_ sender: Any) {
        ClickSound()
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
          //Do nothin
        }
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            UserDefaults.standard.set(false, forKey: "ISUSERLOGGEDIN")
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            Crashlytics.crashlytics().record(error: signOutError)
        }
        
    }
    
    @IBAction func homebutton(_ sender: Any) {
        ClickSound()
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
          //Do nothin
        }
    }
    //Delete User Account
    @IBAction func DeleteUserAccount(_ sender: Any) {
        ClickSound()
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
          //Do nothin
        }
        let user = Auth.auth().currentUser
        
        user?.delete { error in
            if error != nil {
                //Account failed to delete
                Crashlytics.crashlytics().record(error: error!)
                UserDefaults.standard.set(false, forKey: "ISUSERLOGGEDIN")
            } else {
                //Account has been succesfully deleted
                UserDefaults.standard.set(false, forKey: "ISUSERLOGGEDIN")
            }
        }
    }

    @IBAction func REL(_ sender: Any) {
        ClickSound()
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
          //Do nothin
        }
        UserDefaults.standard.set(false, forKey: "Ohio")
        UserDefaults.standard.set(false, forKey: "Indiana")
        UserDefaults.standard.set(false, forKey: "PhillyChapter")
    }
    
    @IBAction func ResetPassword(_ sender: Any) {
        ClickSound()
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
          //Do nothin
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
        
        userData()
        
        label.text = "You are currently signed in as \(UserDefaults.standard.string(forKey: "UserEmail")!)"
    }
}
