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
import FirebaseCrashlytics
class HomeViewController: UIViewController {
    
    let email = UserDefaults.standard.string(forKey: "UserEmail")
    let password = UserDefaults.standard.string(forKey: "UserPassword")
    let intro = UserDefaults.standard.bool(forKey: "Intro_App")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                } else {
                    //Log them out
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
    }
}
