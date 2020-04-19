//
//  ResetPasswordViewController.swift
//  A Kid Again
//
//  Created by Chewy1324 on 5/11/19.
//  Copyright © 2019 Chewy1324. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleMobileAds
import FirebaseCrashlytics
class ResetPasswordViewController: UIViewController, UITextFieldDelegate, GADInterstitialDelegate {

    @IBOutlet weak var emailbox: UITextField!
    @IBOutlet weak var display: UILabel!
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
        
        userHelper_Tool()
        
    }

    @IBAction func button(_ sender: Any) {
        ClickSound()
        if let email = self.emailbox.text {
            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                if error != nil {
                    //error -- did not send email
                    self.display.text = "Error sending email to '\(email)'. Make sure it is a valid email address."
                    if self.interstitial.isReady {
                        self.interstitial.present(fromRootViewController: self)
                    } else {
                      //Do nothin
                    }
                } else {
                    //sent email
                    self.display.text = "The reset password email was succesfuly sent to '\(email)'. Make sure to check your inbox."
                   if self.interstitial.isReady {
                       self.interstitial.present(fromRootViewController: self)
                   } else {
                     //Do nothin
                   }
                }
            }
        }
    }
    
    @IBAction func Sound(_ sender: Any) {
        ClickSound()
        if self.interstitial.isReady {
            self.interstitial.present(fromRootViewController: self)
        } else {
          //Do nothin
        }
    }
}
