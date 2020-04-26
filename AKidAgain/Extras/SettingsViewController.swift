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
class SettingsViewController: UIViewController {

    //Objects
    @IBOutlet weak var label: UILabel!
    
    @IBAction func LogOut(_ sender: Any) {
        ClickSound()
        UserDefaults.standard.set("No_User", forKey: "UserEmail")
        UserDefaults.standard.set("No_User", forKey: "UserPassword")
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
    }

    //Delete User Account
    @IBAction func DeleteUserAccount(_ sender: Any) {
        ClickSound()
        UserDefaults.standard.set("No_User", forKey: "UserEmail")
        UserDefaults.standard.set("No_User", forKey: "UserPassword")
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
        UserDefaults.standard.set(false, forKey: "Ohio")
        UserDefaults.standard.set(false, forKey: "Indiana")
        UserDefaults.standard.set(false, forKey: "PhillyChapter")
    }
    
    @IBAction func ResetPassword(_ sender: Any) {
        ClickSound()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "You are currently signed in as \(UserDefaults.standard.string(forKey: "UserEmail")!)"
    }
}
