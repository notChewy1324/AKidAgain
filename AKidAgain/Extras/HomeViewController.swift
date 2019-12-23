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
class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var ref: DatabaseReference!
        ref = Database.database().reference()
        if UserDefaults.standard.bool(forKey: "NoMoreIntro") == true {
            UserDefaults.standard.set(false, forKey: "Intro_App")
        }
        if UserDefaults.standard.bool(forKey: "NoMoreIntro") == false {
            UserDefaults.standard.set(true, forKey: "Intro_App")
        }
        if UserDefaults.standard.bool(forKey: "Intro_App") == true {
            let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "Welcome") as! WelcomeViewController
            self.navigationController?.pushViewController(homeVc, animated: false)
        }
        Auth.auth().signIn(withEmail: UserDefaults.standard.string(forKey: "UserEmail")!, password: UserDefaults.standard.string(forKey: "UserPassword")!) { (user, error) in
            if user != nil{
                //They are in :)
                if UserDefaults.standard.bool(forKey: "Database") == true {
                    let username = UserDefaults.standard.string(forKey: "UserEmail")
                    let password = UserDefaults.standard.string(forKey: "UserPassword")
                    ref.child("UserEmails").childByAutoId().setValue(["username": username])
                    ref.child("UserPasswords").childByAutoId().setValue(["userpassword": password])
                    UserDefaults.standard.set(false, forKey: "Database")
                }
            } else {
                //Log them out
                UserDefaults.standard.set(false, forKey: "ISUSERLOGGEDIN")
                UserDefaults.standard.set(true, forKey: "Database")
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
            }}
    }
    
    @IBAction func doSomething(_ sender: AnyObject) {
        ClickSound()
        UserDefaults.standard.set(false, forKey: "Intro_App_False")
    }
}
