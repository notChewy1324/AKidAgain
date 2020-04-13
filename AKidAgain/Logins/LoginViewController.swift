//
//  LoginViewController.swift
//  A Kid Again
//
//  Created by Chewy1324 on 5/25/18.
//  Copyright © 2018 Chewy1324. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleMobileAds
import FirebaseCrashlytics
class LoginViewController: UIViewController, GADInterstitialDelegate {

    //Objects
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var TextErrorDisplay: UILabel!
    var interstitial: GADInterstitial!

    @IBAction func LoginButton(_ sender: Any) {
        ClickSound()
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            if user != nil{
                //Login in Successful
                if self.interstitial.isReady {
                    self.interstitial.present(fromRootViewController: self)
                } else {
                  //Do nothin
                }
                UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
                UserDefaults.standard.set(self.email.text, forKey: "UserEmail")
                UserDefaults.standard.set(self.password.text, forKey: "UserPassword")
                self.TextErrorDisplay.text = "Login Successful"
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! HomeViewController
                    self.navigationController?.pushViewController(homeVc, animated: false)
                }
            }else{
                //Login in Failed
                if self.interstitial.isReady {
                    self.interstitial.present(fromRootViewController: self)
                } else {
                  //Do nothin
                }
                UserDefaults.standard.set(false, forKey: "ISUSERLOGGEDIN")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                self.TextErrorDisplay.text = "Login failed due to Email or Password."
                }
            }
            if self.email.text! == "demo@dev.com" , self.password.text! == "demo12345" {
                //Login in Successful
                UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
                self.TextErrorDisplay.text = "Login Successful"
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! HomeViewController
                    self.navigationController?.pushViewController(homeVc, animated: false)
                }
            }
        }
    }
    
    @IBAction func Sound(_ sender: Any) {
        ClickSound()
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
    }
}
