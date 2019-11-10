//
//  SignUpViewController.swift
//  A Kid Again
//
//  Created by Chewy1324 on 5/25/18.
//  Copyright © 2018 Chewy1324. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class SignUpViewController: UIViewController, UITextFieldDelegate {

    //objects
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var TextErrorDisplay: UILabel!
    
    @IBAction func SignUpButton(_ sender: Any) {
        ClickSound()
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (authResult, error) in
            if authResult != nil{
                //Sign Up is Successful
                self.TextErrorDisplay.text = "Sign Up is Successful"
                UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
                UserDefaults.standard.set(self.email.text, forKey: "UserEmail")
                UserDefaults.standard.set(self.password.text, forKey: "UserPassword")
                Auth.auth().currentUser?.sendEmailVerification { (error) in
                    //Sends email to verify account
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! HomeViewController
                    self.navigationController?.pushViewController(homeVc, animated: false)
                }
            }else{
                //Sign Up Failed
                UserDefaults.standard.set(false, forKey: "ISUSERLOGGEDIN")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                self.TextErrorDisplay.text = "Sign Up has failed due to invalid Email Address or the account has been Disabled."
                }
            }
        }
    }
    
    @IBAction func Sound(_ sender: Any) {
        ClickSound()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.delegate = self
        email.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
